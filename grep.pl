use Irssi;

use vars qw($VERSION %IRSSI);

# absolute path to data file #1
$f1 = "/home/web/.irssi/scripts/i3.csv";
# absolute path to fallback data file
$f2 = "/home/web/.irssi/scripts/i3.ascii.csv";
# absolute path to grep.sh script
$grepsh = "/home/web/.irssi/scripts/grep.sh";

$VERSION = "1.0";
%IRSSI = (
		author => 'hunmaat',
		contact => 'orymate@ubuntu.com',
		name => 'neptungrep',
		description => 'Greps for neptun code.',
		license => 'GNU GPL v3 or later',
	 );

sub event_privmsg {
	use vars qw($grepsh $f1 $f2);
	my ($server, $data, $nick, $mask) = @_;

                                            # pattern of query
	my ($target, $text) = $data =~ /^(.*)\s:\.nept? (.*)/;
	if ($text and $target) {
		if ($target !~ /^[#&+!]/) {
			$target = $nick;
		}
		$result = open(GREP,"-|");
		if (!$result) {
			break;
		}
		exec $grepsh, $text , $f1, $f2
			or die("wtf") if $result == 0;
		while (<GREP>) {
			$server->command("msg $target $nick: $_");
		}
		close(GREP);
	}
}

Irssi::signal_add('event privmsg', 'event_privmsg');
