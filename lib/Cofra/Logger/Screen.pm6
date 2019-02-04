use v6;

use Cofra::Logger;

unit class Cofra::Logger::Screen does Cofra::Logger;

has IO::Handle $.handle = $*ERR;

method log-to-screen($level, @msg) {
    $.handle.say: "[$level] @msg.map(*.gist).join('')";
}

method is-logging-critical(--> Bool:D) { True }
method log-critical(*@msg) { self.log-to-screen('critical', @msg) }

method is-logging-error(--> Bool:D) { True }
method log-error(*@msg) { self.log-to-screen('error', @msg) }

method is-logging-warn(--> Bool:D) { True }
method log-warn(*@msg) { self.log-to-screen('warn', @msg) }

method is-logging-info(--> Bool:D) { True }
method log-info(*@msg) { self.log-to-screen('info', @msg) }

method is-logging-debug(--> Bool:D) { True }
method log-debug(*@msg) { self.log-to-screen('debug', @msg) }
