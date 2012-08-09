<!DOCTYPE html>
<html>
<head>
  <title>LIVE SCOREBOARD - MATCH</title>
  <link rel="stylesheet" type="text/css" href="score-style.css" />
</head>
<body>
  <script type="text/javascript">
  setTimeout('window.location.href=window.location.href;', 5000);
  </script>
  <?
  $file = "/opt/HLDS/css/css/cstrike/match.log";	//Change this line to your server's /cstrike folder to open match.log
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
    if (preg_match("/COUNTERTERRORIST (.*)/", $line, $matches))		//Get CT team score
    {
      $is_ct    = 1;
      $ct_score = $matches[1];
    }
    elseif (preg_match("/TERRORIST (.*)/", $line, $matches))		//Get T team score
    {
      $is_ct    = 0;
      $t_score  = $matches[1];
    }
    else
    {
      if (empty($line)) break;						//Get player scores
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
    <td><em>Counter-Terrorists</em></td>			//Print CT team score
    <td id="ct_score"><? echo $ct_score ?></td>
  </tr>
  <tr>
    <td>Player</td>
    <td>Kills</td>
    <td>Deaths</td>
  </tr>
  <?
  foreach ($CounterTerrorists as $ct)				//Print CT player scores
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
    <td><em>Terrorists</em></td>				//Print T team score
    <td id="t_score"><? echo $t_score ?></td>
  </tr>
  <tr>
    <td>Player</td>
    <td>Kills</td>
    <td>Deaths</td>
  </tr>
  <?
  foreach ($Terrorists as $t)					//Print T player scores
  {
    printf("\t<tr>\n");
    printf("\t<td>%s</td><td>%d</td><td>%d</td>\n",$t[0],$t[1],$t[2]);
    printf("\t</tr>\n");
  }
  ?>
  </table>
</body>
</html>
