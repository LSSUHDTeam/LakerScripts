#!/usr/bin/perl

#	Lake Superior State University
#	Josh A. Bosley - 7/26/2017
#	Help Desk Administrator

# Need to install Win32::OLE
# 	ppm install win32-ole
use Win32::OLE;

# Get wirecast obj
my $wirecast = Win32::OLE->GetActiveObject("Wirecast.Application");
if ($wirecast == 0) {
	$wirecast = Win32::OLE->new("Wirecast.Application");
} 

# Check to ensure that we have the wirecast object - Not really needed; but whatever
if ($wirecast) {
 
	# Grab the doc
	my $doc = $wirecast->DocumentByIndex(1);
  
	# Ensure the doc
	if ($doc) {
	
		# Check to see if the stream is broadcasting (returns int 1,0)
		$ib = $doc->isBroadcasting();
		
		# If the stream isn't broadcasting, start it (Brodcast(String) - "start", "stop")
		if ($ib == 0) {
		
			# Attempt to start the stream 
			$doc->Broadcast("start");
			
			# The stream is up
			my $fn = 'camlog.txt';
			open(my $fh, '>>', $fn) or die "Could not open file '$fn' $!";
			
			# Indicate in the log that the stream is up with a time stamp
			my $ctime = localtime(time);
			print $fh "The stream was started @ ";
			print $fh $ctime;
			print $fh "\n---\n";
			close $fh;
			
			
		} else {
		
			# The stream is up
			my $fn = 'camlog.txt';
			open(my $fh, '>>', $fn) or die "Could not open file '$fn' $!";
			
			# Indicate in the log that the stream is up with a time stamp
			my $ctime = localtime(time);
			print $fh "The stream is up ";
			print $fh $ctime;
			print $fh "\n---\n";
			close $fh;
		}
	
	} else {
		print "Unable to obtain DBI..\n";
		exit 1;
	}
}

print "done.\n";
