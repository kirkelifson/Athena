<!DOCTYPE html>
<html>
<head>
    <title>Counter-Strike: Source - Match Scoreboard</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
    <!-- Refresh page every 5 seconds to reflect (almost) live score -->
    <script type="text/javascript">
        setTimeout('window.location.href=window.location.href;', 5000);
    </script>

    <?
        include("parser.php");

        // absolute path structure to match.log
        // ** must have trailing forward-slash **
        $path = "/home/xtc/steam/css/css/cstrike/";
        $file = "match.log";

        $parser = new Parser();
        $parser->read_file($path.$file);
    ?>

    <table>
        <tr>
            <td><em>Counter-Terrorists</em></td>
            <td id="ct_score"><? echo $parser->ct_score; ?></td>
        </tr>

        <tr>
            <td>Player</td>
            <td>Kills</td>
            <td>Deaths</td>
        </tr>

        <? $parser->print_ctscore(); ?>

        <tr>
            <td height="50px"></td>
        </tr>

        <tr>
            <td><em>Terrorists</em></td>
            <td id="t_score"><? echo $parser->t_score; ?></td>
        </tr>

        <tr>
            <td>Player</td>
            <td>Kills</td>
            <td>Deaths</td>
        </tr>

        <? $parser->print_tscore(); ?>

    </table>
</body>
</html>
