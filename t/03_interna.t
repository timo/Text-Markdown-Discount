use v6;
use Test;
use Text::Markdown::Discount;
use lib "{$?FILE.IO.dirname}/data";
use TextMarkdownDiscountTestBoilerplate;


sub test-outputs(Text::Markdown::Discount:D $markdown)
{
    is $markdown.to-str, $simple.to.trim, '...conversion to string works';

    my $file = tmpname;
    $markdown.to-file($file);
    is slurp($file), $simple.to, '...writing to file works';
    unlink $file;
}


{
    my $markdown = Text::Markdown::Discount.from-str($simple.from);
    ok $markdown ~~ Text::Markdown::Discount:D, 'string gets parsed';
    test-outputs($markdown);
}


{
    my $markdown = Text::Markdown::Discount.from-file($simple.md);
    ok $markdown ~~ Text::Markdown::Discount:D, 'file gets parsed';
    test-outputs($markdown);
}

dies-ok { Text::Markdown::Discount.from-file("$data/nonexistent.md") },
        'sourcing from nonexistent file fails';


done-testing