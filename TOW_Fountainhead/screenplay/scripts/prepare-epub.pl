#!/usr/bin/perl

use strict;
use warnings;

use utf8;

use Shlomif::Screenplays::EPUB;

my $gfx = 'towtf-logo-200px.jpg';
my $obj = Shlomif::Screenplays::EPUB->new(
    {
        images =>
        {
            $gfx => "images/$gfx",
        },
    }
);
$obj->run;

my $filename = $obj->filename;

foreach my $part ($filename =~ /\ATOW_Fountainhead_([0-9]+)/g)
{
    my $epub_basename = "TOW_Fountainhead_$part";
    $obj->epub_basename($epub_basename);

    $obj->output_json(
        {
            data =>
            {
                filename => $epub_basename,
                title => qq/The One with The Fountainhead - Part $part/,
                authors =>
                [
                    {
                        name => "Shlomi Fish",
                        sort => "Fish, Shlomi",
                    },
                ],
                contributors =>
                [
                    {
                        name => "Shlomi Fish",
                        role => "oth",
                    },
                ],
                cover => "images/$gfx",
                rights => "Creative Commons Attribution ShareAlike Unported (CC-by-sa-3.0)",
                publisher => 'http://www.shlomifish.org/',
                language => 'en-GB',
                subjects => [ 'FICTION/Humorous', 'FICTION/Mashups', ],
                identifier =>
                {
                    scheme => 'URL',
                    value => 'http://www.shlomifish.org/humour/TOWTF/',
                },
            },
        },
    );
}
