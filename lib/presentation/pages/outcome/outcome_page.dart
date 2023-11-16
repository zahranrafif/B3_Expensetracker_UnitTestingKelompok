import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expensetracker/config/style.dart';
import 'package:expensetracker/domain/helpers/date_formatter.dart';
import 'package:expensetracker/presentation/pages/outcome/add_outcome_page.dart';
import 'package:expensetracker/presentation/pages/outcome/bloc/outcome_bloc.dart';
import 'package:expensetracker/presentation/pages/outcome/edit_outcome_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../config/color.dart';

class OutcomePage extends StatefulWidget {
  const OutcomePage({super.key});

  @override
  State<OutcomePage> createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {
  final _outcomeBloc = OutcomeBloc();
  final dateFormatter = DateFormatter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _outcomeBloc..add(GetDataOutcome()),
      child: BlocListener<OutcomeBloc, OutcomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is OutcomeDeleted) {
            _outcomeBloc.add(GetDataOutcome());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainDarkBlue,
            title: const Text("Pengeluaran"),
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
                        screen: const AddOutcomePage(), withNavBar: false)
                    .then((value) {
                  if (value != null) {
                    List<String> data = List.from(value);
                    if (data.contains('refresh')) {
                      _outcomeBloc.add(GetDataOutcome());
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
    return BlocBuilder<OutcomeBloc, OutcomeState>(
      builder: (context, state) {
        if (state is OutcomeLoaded) {
          return RefreshIndicator(
            onRefresh: () async => _outcomeBloc..add(GetDataOutcome()),
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
                        children: state.data.map((outcome) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: InkWell(
                              onLongPress: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                        screen:
                                            EditOutcomePage(outcome: outcome),
                                        withNavBar: false)
                                    .then((value) {
                                  if (value != null) {
                                    List<String> data = List.from(value);
                                    if (data.contains('refresh')) {
                                      _outcomeBloc.add(GetDataOutcome());
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
                                              .dateFormatYMD(outcome.trxDate),
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11)),
                                      TextSpan(
                                        text: "\n${outcome.description}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 11),
                                      )
                                    ]),
                                  ),
                                  title: Text(
                                    outcome.isIncome
                                        ? '\n ${NumberFormat.simpleCurrency(locale: 'id').format(outcome.amount)}'
                                        : '\n - ${NumberFormat.simpleCurrency(locale: 'id').format(outcome.amount)}',
                                    style: outcome.isIncome
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
                                          context, _outcomeBloc, outcome.id);
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

showDeleteDialog(BuildContext context, OutcomeBloc bloc, String id) {
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
      bloc.add(DeleteOutcome(id: id));
      Navigator.of(context, rootNavigator: true).pop('dialog');
      () async => bloc..add(GetDataOutcome());
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
