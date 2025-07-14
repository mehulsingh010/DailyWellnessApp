import 'package:dailywellness_app/routes/routes.dart';
import 'package:dailywellness_app/utils/task_utils.dart';
import 'package:dailywellness_app/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/task_provider.dart';
import '../services/quote_service.dart';
import '../models/quote.dart';
import '../widgets/task_item.dart';
import '../constants/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<Quote> _quoteFuture;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadEmail();
    _quoteFuture = QuoteService.fetchQuote();
  }

  Future<void> _loadEmail() async {
    String? email = await UserPreferences.getEmail();
    setState(() {
      userEmail = email;
    });
  }

  void _logout(BuildContext context) async {
    await UserPreferences.clearEmail();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void _refreshQuote() {
    setState(() {
      _quoteFuture = QuoteService.fetchQuote();
    });
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Are you sure you want to logout?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); //close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Logout button color
              ),
              onPressed: () {
                Navigator.of(context).pop(); //close dialog
                _logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final currentDate = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    final currentTime = DateFormat('HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: tdBlue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.spa, size: 40, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'DailyWellness',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Personal Wellness Tracker',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome ,${userEmail?.trim().split('@')[0] ?? 'User'}",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = orientation == Orientation.landscape;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting Section
                    _buildGreetingSection(currentDate, currentTime),
                    const SizedBox(height: 24),

                    if (isLandscape) ...[
                      // Landscape layout - side by side
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _buildTasksSection(taskProvider),
                          ),
                          const SizedBox(width: 16),
                          Expanded(flex: 1, child: _buildQuoteSection()),
                        ],
                      ),
                    ] else ...[
                      // Portrait layout - stacked
                      _buildTasksSection(taskProvider),
                      const SizedBox(height: 24),
                      _buildQuoteSection(),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addActivity);
        },
        backgroundColor: tdBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildGreetingSection(String date, String time) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tdBlue.withValues(alpha: 0.5),
            Colors.teal.withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${userEmail?.trim().split('@')[0] ?? 'User'}! 👋',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: tdBlack,
            ),
          ),
          SizedBox(height: 8),
          Text(date, style: TextStyle(fontSize: 16, color: tdGrey)),
          Text(time, style: TextStyle(fontSize: 14, color: tdGrey)),
        ],
      ),
    );
  }

  Widget _buildTasksSection(TaskProvider taskProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Wellness Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              '${taskProvider.completedTasksCount}/${taskProvider.tasks.length}',
              style: TextStyle(fontSize: 14, color: tdGrey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          TaskUtils.formatTaskCount(taskProvider.completedTasksCount),
          style: TextStyle(fontSize: 14, color: tdGrey),
        ),
        const SizedBox(height: 8),
        if (taskProvider.tasks.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No tasks yet. Add your first wellness activity!',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...taskProvider.tasks.map(
            (task) => TaskItem(
              task: task,
              onToggle: () => taskProvider.toggleTask(task.id),
              onDelete: () => taskProvider.removeTask(task.id),
            ),
          ),
      ],
    );
  }

  Widget _buildQuoteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daily Motivation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshQuote,
              tooltip: 'Refresh Quote',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal, width: 1.5),
          ),
          child: FutureBuilder<Quote>(
            future: _quoteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(height: 8),
                    const Text(
                      'Failed to load quote',
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _refreshQuote,
                      child: const Text('Retry'),
                    ),
                  ],
                );
              } else if (snapshot.hasData) {
                final quote = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      '"${quote.body}"',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '- ${quote.author}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              } else {
                return const Text('No quote available');
              }
            },
          ),
        ),
      ],
    );
  }
}
