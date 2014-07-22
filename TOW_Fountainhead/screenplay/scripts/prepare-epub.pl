#!/usr/bin/perl

use strict;
use warnings;

use IO::All;
use JSON::MaybeXS qw(encode_json);

use utf8;

use Shlomif::Screenplays::EPUB;

my $obj = Shlomif::Screenplays::EPUB->new;
$obj->run;

my $gfx = $obj->gfx;
my $filename = $obj->filename;
my $out_fn = $obj->out_fn;
my $target_dir = $obj->target_dir;


foreach my $part ($filename =~ /\ATOW_Fountainhead_([0-9]+)/g)
{
    my $epub_basename = "TOW_Fountainhead_$part";
    $obj->epub_basename($epub_basename);
    io->file($target_dir . '/' . $obj->json_filename)->utf8->print(
        encode_json(
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
                rights => "Creative Commons Attribution ShareAlike Unported (CC-by-3.0)",
                publisher => 'http://www.shlomifish.org/',
                language => 'en-GB',
                subjects => [ 'FICTION/Horror', 'FICTION/Humorous', 'FICTION/Masups', ],
                identifier =>
                {
                    scheme => 'URL',
                    value => 'http://www.shlomifish.org/humour/TOWTF/',
                },
                contents =>
                [
                    {
                        "type" => "toc",
                        "source" => "toc.html"
                    },
                    {
                        type => 'text',
                        source => "scene-*.xhtml",
                    },
                ],
                toc  => {
                    "depth" => 2,
                    "parse" => [ "text", ],
                    "generate" => {
                        "title" => "Index"
                    },
                },
                guide => [
                    {
                        type => "toc",
                        title => "Index",
                        href => "toc.html",
                    },
                ],
            },
        ),
    );

    $obj->output_json;
}
