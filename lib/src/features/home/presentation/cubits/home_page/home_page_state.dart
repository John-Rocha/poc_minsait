part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final List<PersonEntity> persons;
  final bool isLoading;
  final String errorMessage;

  const HomePageState({
    required this.persons,
    required this.isLoading,
    required this.errorMessage,
  });

  const HomePageState.initial()
      : persons = const [],
        isLoading = false,
        errorMessage = '';

  HomePageState copyWith({
    List<PersonEntity>? persons,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomePageState(
      persons: persons ?? this.persons,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [persons, isLoading, errorMessage];
}
