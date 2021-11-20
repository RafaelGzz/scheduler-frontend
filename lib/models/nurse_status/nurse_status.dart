class Shift {
  DateTime? initTurn;
  DateTime? endTurn;

  DateTime? initBreak;
  DateTime? endBreak;
  
  int totalBreakHours;
  int totalWorkedHours;

  bool turnRunning;
  bool breakRunning;
  Shift({
    this.initTurn,
    this.endTurn,
    this.initBreak,
    this.endBreak,
    this.breakRunning = false,
    this.turnRunning = true,
    this.totalBreakHours = 0,
    this.totalWorkedHours = 0,
  }) {
    initTurn = initTurn ?? DateTime.now();
  }

  Shift copyWith({
    DateTime? initTurn,
    DateTime? endTurn,
    DateTime? initBreak,
    DateTime? endBreak,
    bool? turnRunning,
    bool? breakRunning,
    int? totalBreakHours,
    int? totalWorkedHours,
    bool forceEndBreakNull = false,
  }) {
    return Shift(
      breakRunning: breakRunning ?? this.breakRunning,
      initBreak: initBreak ?? this.initBreak,
      endBreak: forceEndBreakNull ? null : endBreak ?? this.endBreak,
      endTurn: endTurn ?? this.endTurn,
      initTurn: initTurn ?? this.initTurn,
      turnRunning: turnRunning ?? this.turnRunning,
      totalBreakHours: totalBreakHours ?? this.totalBreakHours,
      totalWorkedHours: totalWorkedHours ?? this.totalWorkedHours,
    );
  }
}

class NurseStatus {
  int nurseId;
  List<Shift>? shifts;

  NurseStatus({
    required this.nurseId,
    this.shifts,
  });

  get turnRunning => shifts?.last.turnRunning ?? false;
  get breakRunning => shifts?.last.breakRunning ?? false;

  DateTime? get initTurn => shifts?.last.initTurn;
  DateTime? get endTurn => shifts?.last.endTurn;
  DateTime? get initBreak => shifts?.last.initBreak;
  DateTime? get endBreak => shifts?.last.endBreak;
  int get totalBreakHours => shifts?.last.totalBreakHours ?? 0;
  int get totalWorkedHours => shifts?.last.totalWorkedHours ?? 0;
}
