import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class GroupEvent {}

class SetGroupName extends GroupEvent {
  final String name;
  SetGroupName(this.name);
}

class AddMember extends GroupEvent {
  final String memberName;
  AddMember(this.memberName);
}

class SetTotalAmount extends GroupEvent {
  final double amount;
  SetTotalAmount(this.amount);
}

class ResetGroup extends GroupEvent {}

// State
class GroupState {
  final String groupName;
  final List<String> members;
  final double totalAmount;

  GroupState({
    this.groupName = '',
    this.members = const [],
    this.totalAmount = 0,
  });

  double get split => members.isEmpty ? 0 : totalAmount / members.length;

  GroupState copyWith({
    String? groupName,
    List<String>? members,
    double? totalAmount,
  }) {
    return GroupState(
      groupName: groupName ?? this.groupName,
      members: members ?? this.members,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

// Bloc
class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupState()) {
    on<SetGroupName>((event, emit) {
      emit(state.copyWith(groupName: event.name.trim()));
    });

    on<AddMember>((event, emit) {
      emit(state.copyWith(
        members: List.from(state.members)..add(event.memberName.trim()),
      ));
    });

    on<SetTotalAmount>((event, emit) {
      emit(state.copyWith(totalAmount: event.amount));
    });

    on<ResetGroup>((event, emit) {
      emit(GroupState());
    });
  }
}

// UI
class GroupInputScreen extends StatelessWidget {
  const GroupInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupBloc(),
      child: const GroupInputView(),
    );
  }
}

class GroupInputView extends StatefulWidget {
  const GroupInputView({super.key});

  @override
  State<GroupInputView> createState() => _GroupInputViewState();
}

class _GroupInputViewState extends State<GroupInputView> {
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _memberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _groupCreated = false;

  // Add this for dropdown
  final List<String> _itemTypes = ['Food', 'Drink', 'Other'];
  String? _selectedItemType;

  @override
  void dispose() {
    _groupController.dispose();
    _memberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Group Splitter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            return Column(
              children: [
                if (!_groupCreated)
                  TextField(
                    controller: _groupController,
                    decoration: const InputDecoration(
                      labelText: 'Group Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                if (!_groupCreated)
                  ElevatedButton(
                    onPressed: () {
                      String name = _groupController.text.trim();
                      if (name.isEmpty) {
                        _showError(context, 'Group name cannot be empty');
                        return;
                      }
                      context.read<GroupBloc>().add(SetGroupName(name));
                      setState(() => _groupCreated = true);
                    },
                    child: const Text('Set Group Name'),
                  ),
                if (_groupCreated)
                  TextField(
                    controller: TextEditingController(text: state.groupName),
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Group Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _memberController,
                        decoration: const InputDecoration(
                          labelText: 'Member Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String name = _memberController.text.trim();
                        if (name.isEmpty) {
                          _showError(context, 'Member name cannot be empty');
                          return;
                        }
                        context.read<GroupBloc>().add(AddMember(name));
                        _memberController.clear();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.members.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${index + 1}. ${state.members[index]}'),
                      );
                    },
                  ),
                ),
                if (state.members.isNotEmpty) ...[
                  const Divider(),
                  // Dropdown for item type
                  DropdownButtonFormField<String>(
                    value: _selectedItemType,
                    decoration: const InputDecoration(
                      labelText: 'Select Item Type',
                      border: OutlineInputBorder(),
                    ),
                    items: _itemTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedItemType = val;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Enter Total Amount',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      final amount = double.tryParse(val) ?? 0;
                      context.read<GroupBloc>().add(SetTotalAmount(amount));
                    },
                  ),
                  const SizedBox(height: 10),
                  Text('Total: ₹${state.totalAmount.toStringAsFixed(2)}'),
                  Text('Each Pays: ₹${state.split.toStringAsFixed(2)}'),
                ],
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<GroupBloc>().add(ResetGroup());
                    setState(() {
                        _groupCreated = false;
                        _groupController.clear();
                        _memberController.clear();
                        _amountController.clear();
                      _memberController.clear();
                      _amountController.clear();
                    });
                  },
                  child: const Text('Reset Group'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
