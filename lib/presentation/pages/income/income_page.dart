import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expensetracker/config/style.dart';
import 'package:expensetracker/domain/helpers/date_formatter.dart';
import 'package:expensetracker/presentation/pages/income/add_income_page.dart';
import 'package:expensetracker/presentation/pages/income/bloc/income_bloc.dart';
import 'package:expensetracker/presentation/pages/income/edit_income_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../config/color.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final _incomeBloc = IncomeBloc();
  final dateFormatter = DateFormatter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _incomeBloc..add(GetDataIncome()),
      child: BlocListener<IncomeBloc, IncomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is IncomeDeleted) {
            _incomeBloc.add(GetDataIncome());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainDarkBlue,
            title: const Text("Pemasukan"),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration:
                        const BoxDecoration(color: mainBackgroundWhite)),
                listItems()
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const AddIncomePage(), withNavBar: false)
                    .then((value) {
                  if (value != null) {
                    List<String> data = List.from(value);
                    if (data.contains('refresh')) {
                      _incomeBloc.add(GetDataIncome());
                    }
                  }
                });
              },
              backgroundColor: mainDarkBlue,
              child: const Icon(CupertinoIcons.add),
            ),
          ),
        ),
      ),
    );
  }

  Widget listItems() {
    return BlocBuilder<IncomeBloc, IncomeState>(
      builder: (context, state) {
        if (state is IncomeLoaded) {
          return RefreshIndicator(
            onRefresh: () async => _incomeBloc..add(GetDataIncome()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                              top: Radius.circular(10)),
                          color: Colors.white),
                      child: ListView(
                        children: state.data.map((income) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: InkWell(
                              onLongPress: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                        screen: EditIncomePage(income: income),
                                        withNavBar: false)
                                    .then((value) {
                                  if (value != null) {
                                    List<String> data = List.from(value);
                                    if (data.contains('refresh')) {
                                      _incomeBloc.add(GetDataIncome());
                                    }
                                  }
                                });
                              },
                              child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: dateFormatter
                                              .dateFormatYMD(income.trxDate),
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11)),
                                      TextSpan(
                                        text: "\n${income.description}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 11),
                                      )
                                    ]),
                                  ),
                                  title: Text(
                                    income.isIncome
                                        ? '\n ${NumberFormat.simpleCurrency(locale: 'id').format(income.amount)}'
                                        : '\n - ${NumberFormat.simpleCurrency(locale: 'id').format(income.amount)}',
                                    style: income.isIncome
                                        ? const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11)
                                        : const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      showDeleteDialog(
                                          context, _incomeBloc, income.id);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

showDeleteDialog(BuildContext context, IncomeBloc bloc, String id) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Batalkan"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget continueButton = TextButton(
    child: const Text(
      "Hapus",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      bloc.add(DeleteIncome(id: id));
      Navigator.of(context, rootNavigator: true).pop('dialog');
      () async => bloc..add(GetDataIncome());
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("AlertDialog"),
    content: const Text("Apakah anda yakin ingin menghapus data ini?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
