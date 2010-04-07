use Irssi;

use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
		author => 'hunmaat',
		contact => 'orymate@ubuntu.com',
		name => 'neptungrep',
		description => 'Greps for neptun code.',
		license => 'GNU GPL v3 or later',
	 );

sub event_privmsg {
	my ($server, $data, $nick, $mask) = @_;

	my ($target, $text) = $data =~ /^(.*)\s:\.nept? (.*)/;
	if ($text and $target) {
		if ($target !~ /^[#&]/) {
			$target = $nick;
		}
		$result = open(GREP,"-|");
		exec "/home/web/.irssi/scripts/grep.sh", $text 
			or die("wtf") if $result == 0;
		while (<GREP>) {
			$server->command("msg $target $nick: $_");
			last;
		}
		close(GREP);
	}
}

Irssi::signal_add('event privmsg', 'event_privmsg');
