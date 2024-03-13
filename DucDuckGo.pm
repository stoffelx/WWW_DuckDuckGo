# Version: $Id: DuckDuckGo.pm,v 0.1 2024/03/11 CH
package Parsers::TargetParser::WWW::DuckDuckGo;
use base qw(Parsers::TargetParser);
use Parsers::TargetParser::Debug qw(debug error);
use strict;

sub getWebSearch {
    my ($this)    = @_;
    my $ctx_obj   = $this->{ctx_obj};

    debug "Forcing ctx_obj to return utf8.";
    $ctx_obj->set('sfx.char_set', 'utf8');

    my $bookTitle = $ctx_obj->get('rft.btitle');
    my $artTitle  = $ctx_obj->get('rft.atitle');
    my $title     = length $artTitle ? $artTitle : $bookTitle;

        if ( length $title > 100 ) {
                $title = substr( $title, 0, 100 );
                $title =~ s/\s+\S*$//o;
        }
        $title =~ s/[:?]//g;

    my $url = URI->new("https://duckduckgo.com");
    $url->query_form( t => 'h_', q => $title, ia => 'web');

    return $url;
}

1;