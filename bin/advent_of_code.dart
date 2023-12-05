import 'package:advent_of_code/calendar.dart';
import 'package:args/args.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addOption(
      'day',
      abbr: 'd',
      help: 'Day on the calendar to run',
    )
    ..addOption(
      'input_directory',
      abbr: 'i',
      help: 'Specify the directory to get input data from.',
      defaultsTo: './inputs',
    )
    ..addOption(
      'part',
      abbr: 'p',
      help: 'Specify what part of the puzzle to run.',
      defaultsTo: '2',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart advent_of_code.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  int day = DateTime.now().day;
  int part = 2;
  String inputDirectory = "./inputs";
  try {
    final ArgResults results = argParser.parse(arguments);
    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('advent_of_code version: $version');
      return;
    }
    if (results.wasParsed('day')) {
      day = int.parse(results['day']);
    }
    if (results.wasParsed('input_directory')) {
      inputDirectory = results['input_directory'];
    }
    if (results.wasParsed('part')) {
      part = int.parse(results['part']);
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
  print("Solving Day $day of AOC 2023!");
  Calendar calendar = Calendar(inputDirectory: inputDirectory);
  print(calendar.executeSolution(day, part));
}
