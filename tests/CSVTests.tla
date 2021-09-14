---------------------------- MODULE CSVTests ----------------------------
EXTENDS CSV, TLC, Sequences, IOUtils

ASSUME LET T == INSTANCE TLC IN T!PrintT("CSVTests")

Template ==
    \* '#' symbol is probably best separator for TLA+.
    "%1$s#%2$s#%3$s"

Value ==
    << 42, "abc", [a |-> "a", b |-> "b"] >>

ToFile == 
    "build/tests/CSVWriteTest-" \o ToString(JavaTime) \o ".csv"

\* Write Value to ToFile then check success by reading with IOExec. 
ASSUME(
  CSVWrite(Template, Value, ToFile) 
    => 
      /\ IOExec(<< "cat", ToFile >>).stdout = "42#\"abc\"#[a |-> \"a\", b |-> \"b\"]\n")
      /\ CSVRecords(ToFile) = 1

ASSUME
  CSVRecords("DoesNotExistNowhere.tla") = 0
  
=============================================================================
                                                                    
