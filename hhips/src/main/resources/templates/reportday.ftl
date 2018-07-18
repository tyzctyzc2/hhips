<html>
<head>
   <meta charset="utf-8"/>
   <title>Chapter List</title>
   <link href="./jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
   <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
   <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
   <script type="text/javascript" src="./jqueryui/jquery-ui.js"></script>

</head>
   <body>
      <table>
            <tr>
                <td>
                    <a href="./Source" style="text-decoration: none">
                        <h1>题源目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                </td>
                <td>
                    <a href="./Problem?paperid=-1" style="text-decoration: none">
                        <h1>卷卷目录</h1>
                </td>
            </tr>
        </table>
        <div    style = text-align: right;>
            <p>Date: <input type="text" id="datepicker"></p>
        </div>
      <h1>${wantday}</h1>
      <table class=edge>
        <tr>
            <th class=edge>类别</th>
            <th class=edge>总时间</th>
            <th class=edge>次数</th>
        </tr>
        <tr>
            <td class=edge>正确</td>
            <td class=edge>${totalCorrectUsedTime}</td>
            <td class=edge>${totalCorrectTime}</td>
        </tr>
        <tr>
            <td class=edge>错误</td>
            <td class=edge>${totalWrongUsedTime}</td>
            <td class=edge>${totalWrongTime}</td>
        </tr>
        <tr>
            <td class=edge>未知</td>
            <td class=edge>${totalUnknownUsedTime}</td>
            <td class=edge>${totalUnknownTime}</td>
        </tr>
      </table>
      <table>

      <#if maxseg != -1>
      <#list 0..maxseg as i>
          <tr>
          <td style="white-space: nowrap;">${segworks[i].startdate?time}</td>
            <td>
          <#if segworks[i].workmark != 0>
                <p class="edge" style="height: 20px; float:left; width:${segworks[i].usedtime?c}0px;background-color:green">${segworks[i].usedtime?c}</p>
            <#else>
                <p class="edge" style="height: 20px; float:left; width:${segworks[i].usedtime?c}0px;background-color:red">${segworks[i].usedtime?c}</p>
            </#if>
            </td>
            </tr>
      </#list>
      </#if>

      </table>
        <#if workbypaper?exists>
            <#list workbypaper?keys as paperkey>

            </#list>
        </#if>
   </body>
   <script>
      $( function() {
        $( "#datepicker" ).datepicker({ dateFormat: "yymmdd" });
        $("#datepicker").on("change",function(){
                var selected = $(this).val();
                var date = $('#datepicker').datepicker({ dateFormat: 'yyyymmdd' }).val();
                console.log(date);
                window.location='./Report?wantday='+date;
            });
      } );
      </script>
</html>