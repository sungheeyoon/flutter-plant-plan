
// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<PlantBloc>(context).add(GetPlantListEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Firebase test")),
//       body: BlocBuilder<PlantBloc, PlantState>(
//         builder: (context, state) {
//           if (state is Loaded) {
//             List<Plant> data = state.plants;
//             return Expanded(
//                 child: ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(data[index].name),
//                     trailing: Text(data[index].id.toString()),
//                   ),
//                 );
//               },
//             ));
//           } else if (state is Loading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }
