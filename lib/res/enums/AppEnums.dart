enum DateStatus{
  TODAY('TODAY'),
  PAST_DAY('PAST DAY'),
  NEXT_DAY('NEXT DAY');

  const DateStatus(this.name);

  final String name;
}