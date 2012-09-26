<!DOCTYPE html>
<html>
<head>
  <title>Counter-Strike: Source - Match Scoreboard</title>
  <link rel="stylesheet" type="text/css" href="score-style.css" />
</head>
<body>
  <script type="text/javascript">
  <!-- Refresh page every 5 seconds to reflect (almost) live score -->
  setTimeout('window.location.href=window.location.href;', 5000);
  </script>
  <?
  // path to match.log
  $file = "/opt/HLDS/css/css/cstrike/match.log";
  $log  = fopen($file, 'r') or die("FILE READ ERROR");
  $ct_score = 0;
  $t_score  = 0;

  $is_ct  = 0;

  $gCounter_ct  = 0;
  $gCounter_t   = 0;

  $CounterTerrorists=array();
  $Terrorists=array();

  while (!feof($log))
  {
    $line = fgets($log);

    // Filter out Counter-Terrorist team score
    if (preg_match("/COUNTERTERRORIST (.*)/", $line, $matches))
    {
      $is_ct    = 1;
      $ct_score = $matches[1];
    }

    // Filter out Terrorist team score
    elseif (preg_match("/TERRORIST (.*)/", $line, $matches))
      $is_ct    = 0;
      $t_score  = $matches[1];
    }

    /* 
     * If team score line isn't detected it's a player score:
     *  1. Check flag to note which team player belongs to
     *  2. Split buffer into chunks based on name, kills, & deaths
     *  3. Add to team roster array
     */
    else
    {
      // Fill array containing each player's score
      if (empty($line)) break;
      $split  = explode(",",$line);
      $nick   = $split[0];
      $kills  = $split[1];
      $deaths = $split[2];
      if ($is_ct)
        $CounterTerrorists[$gCounter_ct++]=array($nick,$kills,$deaths);
      else
        $Terrorists[$gCounter_t++]=array($nick,$kills,$deaths);
    }
  }
  fclose($log);
  ?>
  <table>
  <tr>
    <td><em>Counter-Terrorists</em></td>
    <td id="ct_score"><? echo $ct_score ?></td>
  </tr>
  <tr>
    <td>Player</td>
    <td>Kills</td>
    <td>Deaths</td>
  </tr>
  <?
  // Print Counter-Terrorist team score + player scores
  foreach ($CounterTerrorists as $ct)
  {
    printf("\t<tr>\n");
    printf("\t<td>%s</td><td>%d</td><td>%d</td>\n",$ct[0],$ct[1],$ct[2]);
    printf("\t</tr>\n");
  }
  ?>
  <tr>
    <td height="50px"></td>
  </tr>
  <tr>
    <td><em>Terrorists</em></td>
    <td id="t_score"><? echo $t_score ?></td>
  </tr>
  <tr>
    <td>Player</td>
    <td>Kills</td>
    <td>Deaths</td>
  </tr>
  <?
  // Print Terrorist team score + player scores
  foreach ($Terrorists as $t)
  {
    printf("\t<tr>\n");
    printf("\t<td>%s</td><td>%d</td><td>%d</td>\n",$t[0],$t[1],$t[2]);
    printf("\t</tr>\n");
  }
  ?>
  </table>
</body>
</html>
