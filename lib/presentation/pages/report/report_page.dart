import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/domain/models/chart/chart_model.dart';
import 'package:expensetracker/domain/models/report/report_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expensetracker/config/color.dart';
import 'package:expensetracker/config/style.dart';
import 'package:expensetracker/domain/helpers/date_formatter.dart';
import 'package:expensetracker/domain/models/report/report_model.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';
import 'package:expensetracker/presentation/pages/report/bloc/report_bloc.dart';
import 'package:expensetracker/presentation/pages/report/bloc/transaction_recap_bloc.dart';
import 'package:expensetracker/presentation/widgets/inputs/input_date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportBloc = ReportBloc();
  final _recapBloc = TransactionRecapBloc();

  final dateFormatter = DateFormatter();

  final _startDateCtrl = TextEditingController();
  final _endDateCtrl = TextEditingController();
  final _filterDateCtrl = TextEditingController();

  final now = DateTime.now();

  @override
  void initState() {
    _startDateCtrl.text =
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 7)));
    _endDateCtrl.text = DateFormat('yyyy-MM-dd').format(now);
    _filterDateCtrl.text =
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 7)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainDarkBlue,
        title: const Text("Laporan"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => refreshData(),
        child: SafeArea(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: mainBackgroundWhite),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocProvider(
                      create: (context) => refreshDataReport(),
                      child: BlocBuilder<ReportBloc, ReportState>(
                        builder: (context, state) {
                          if (state is ReportLoaded) {
                            
                            return _dailyReportCard(state.data);
                          } else {
                            return _dailyReportCard(ReportViewModel(dailyReports: [], maxIncome: 0, maxOutcome: 0, totalIncome: 0, totalOutcome: 0));
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocProvider(
                      create: (context) => refreshDataRecap(),
                      child: BlocBuilder<TransactionRecapBloc, TransactionRecapState>(
                        builder: (context, state) {
                          if (state is TransactionRecapLoaded) {
                            return _transactionCard(state.data);
                          } else {
                            return _transactionCard([]);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )),
        )),
      ),
    );
  }

  Widget _dailyReportCard(ReportViewModel reportView) {
    int max = reportView.maxIncome > reportView.maxOutcome ? reportView.maxIncome : reportView.maxOutcome;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(0), top: Radius.circular(10)),
                  color: mainDarkBlue),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Perbandingan Pemasukan dan Pengeluaran',
                    style: TextStyle(
                        color: mainBackgroundWhite,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Form(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("Mulai"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: InputDate(
                                      validatorMessage: "-",
                                      labelText: "-",
                                      keyboardType: TextInputType.datetime,
                                      controller: _startDateCtrl,
                                      style: 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Sampai"),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: InputDate(
                                    validatorMessage: "-",
                                    labelText: "-",
                                    keyboardType: TextInputType.datetime,
                                    controller: _endDateCtrl,
                                    style: 2),
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () async => refreshDataReport(),
                            icon: const Icon(CupertinoIcons.search_circle_fill),
                            color: mainDarkBlue,
                          )
                        ],
                      ),
                    ),
                  ),
                  _chartBar(max, reportView.dailyReports),
                  const SizedBox(height: 10,),
                  _chartPie(reportView.totalIncome, reportView.totalOutcome),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration:
                            const BoxDecoration(gradient: gradientGreenStyle),
                      ),
                      const Text(" Pemasukan "),
                      const SizedBox(width: 20),
                      Container(
                        height: 10,
                        width: 10,
                        decoration:
                            const BoxDecoration(gradient: gradientRedStyle),
                      ),
                      const Text(" Pengeluaran "),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartBar(int max, List<ReportModel> reports){
    final _tooltip = TooltipBehavior();
    
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: max.toDouble(),
          interval: 500000),
      tooltipBehavior: _tooltip,
      series: <ChartSeries<ReportModel, String>>[
        ColumnSeries<ReportModel, String>(
            dataSource: reports,
            xValueMapper: (ReportModel data, _) => data.date,
            yValueMapper: (ReportModel data, _) => data.income,
            name: 'Pemasukan',
            gradient: gradientGreenStyle),
        ColumnSeries<ReportModel, String>(
            dataSource: reports,
            xValueMapper: (ReportModel data, _) => data.date,
            yValueMapper: (ReportModel data, _) => data.outcome,
            name: 'Pengeluaran',
            gradient: gradientRedStyle)
      ]);
  }

  Widget _chartPie(int income, int outcome){

    final List<ChartModel> chartData = [
      ChartModel('Income', income.toDouble(), Colors.green),
      ChartModel('Outcome', outcome.toDouble(), Colors.red)
    ];

    if(!(income == 0 && outcome == 0)){
      return SfCircularChart(
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartModel, String>(
            dataSource: chartData,
            pointColorMapper:(ChartModel data,  _) => data.color,
            xValueMapper: (ChartModel data, _) => data.x,
            yValueMapper: (ChartModel data, _) => data.y
          )
        ]
      );
    }else{
      return const Text("");
    }
    
  }

  Widget _transactionCard(List<TransactionModel> transactions) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(0), top: Radius.circular(10)),
                  color: mainDarkBlue),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Rekap transaksi per hari',
                    style: TextStyle(
                        color: mainBackgroundWhite,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Form(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Transaksi pada "),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: InputDate(
                                  validatorMessage: "-",
                                  labelText: "-",
                                  keyboardType: TextInputType.datetime,
                                  controller: _filterDateCtrl,
                                  style: 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () async => refreshDataRecap(),
                        icon: const Icon(CupertinoIcons.search_circle_fill),
                        color: mainDarkBlue,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: transactions.map((e) {
                  return _transactionItemCard(e);
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  refreshData(){
    refreshDataReport();
    refreshDataRecap();
  }

  ReportBloc refreshDataReport() {
    return _reportBloc
      ..add(GetDataReport(
          startDate: dateFormatter.dateFormatYMD(
              Timestamp.fromDate(DateTime.parse(_startDateCtrl.text))),
          endDate: dateFormatter.dateFormatYMD(
              Timestamp.fromDate(DateTime.parse(_endDateCtrl.text))),
          filterDate:
              Timestamp.fromDate(DateTime.parse(_filterDateCtrl.text))));
  }

  TransactionRecapBloc refreshDataRecap() {
    return _recapBloc
      ..add(GetDataTransactionRecap(
          filterDate:
              Timestamp.fromDate(DateTime.parse(_filterDateCtrl.text))));
  }

  Widget _transactionItemCard(TransactionModel transaction) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      child: ListTile(
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: dateFormatter.dateFormatYMD(transaction.trxDate),
                  style: const TextStyle(color: Colors.grey)),
              TextSpan(
                text: "\n${transaction.description}",
                style: const TextStyle(color: Colors.black),
              )
            ]),
          ),
          trailing: Text(
            transaction.isIncome
                ? NumberFormat.simpleCurrency(locale: 'id')
                    .format(transaction.amount)
                : '- ${NumberFormat.simpleCurrency(locale: 'id').format(transaction.amount)}',
            style:
                transaction.isIncome ? incomeNumberStyle : outcomeNumberStyle,
          )),
    );
  }
}