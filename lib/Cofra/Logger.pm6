use v6;

unit role Cofra::Logger;

method is-logging-critical(--> Bool:D) { ... }
method log-critical(*@msg) { ... }

method is-logging-error(--> Bool:D) { ... }
method log-error(*@msg) { ... }

method is-logging-warn(--> Bool:D) { ... }
method log-warn(*@msg) { ... }

method is-logging-info(--> Bool:D) { ... }
method log-info(*@msg) { ... }

method is-logging-debug(--> Bool:D) { ... }
method log-debug(*@msg) { ... }
