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
                        <h1>卷卷目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                </td>
                <td>
                    <a href="./" style="text-decoration: none">
                        <h1>首页</h1>
                </td>
            </tr>
        </table>
        <div    style = text-align: right;>
            <p>Date: <input type="text" id="datepicker"></p>
        </div>
        <h1>${wantday}</h1>
        <div id="tabs">
            <ul>
                <li><a href="#summary">Summary</a></li>
                <li><a href="#timesummary">Time Summary</a></li>
                <li><a href="#papersummary">Paper Summary</a></li>
            </ul>
            <div id="summary">
                <table class=edge>
                    <tr>
                        <th class=edge>类别</th>
                        <th class=edge>总时间</th>
                        <th class=edge>次数</th>
                        <th class=edge>Avg.</th>
                    </tr>
                    <tr>
                        <td class=edge>正确</td>
                        <td class=edge>${totalCorrectUsedTime}</td>
                        <td class=edge>${totalCorrectTime}</td>
                        <td class=edge>${avgCorrect}</td>
                    </tr>
                    <tr>
                        <td class=edge>错误</td>
                        <td class=edge>${totalWrongUsedTime}</td>
                        <td class=edge>${totalWrongTime}</td>
                        <td class=edge>${avgWrong}</td>
                    </tr>
                    <tr>
                        <td class=edge>未知</td>
                        <td class=edge>${totalUnknownUsedTime}</td>
                        <td class=edge>${totalUnknownTime}</td>
                        <td class=edge>${avgUnknown}</td>
                    </tr>
                    <tr>
                        <td class=edge>总计</td>
                        <td class=edge>${totalUsedTime}</td>
                        <td class=edge>${totalTimes}</td>
                        <td class=edge>${avgTotal}</td>
                    </tr>
                </table>
            </div>

            <table id="timesummary">
                <#if maxseg != -1>
                    <#list 0..maxseg as i>
                        <tr>
                            <td style="white-space: nowrap;">${segworks[i].startdate?time}</td>
                            <td>
                                <#assign len=segworks[i].usedtime>
                                <#if len==0>
                                <#assign len=1>
                                </#if>
                                <#if segworks[i].workmark != 0>
                                <p class="edge" style="height: 20px; float:left; width:${len?c}0px;background-color:green">${segworks[i].usedtime?c}</p>
                                <#else>
                                <p class="edge" style="height: 20px; float:left; width:${len?c}0px;background-color:red">${segworks[i].usedtime?c}</p>
                                </#if>
                            </td>
                        </tr>
                    </#list>
                </#if>
            </table>
            <table id="papersummary">
                <#if workbypaper?exists>
                    <#list workbypaper?keys as paperid>
                        <#assign paper = workbypaper[paperid]>
                        <#assign paperfirst=1>
                            <#list paper?keys as problemid>
                                <#assign problem = paper[problemid]>
                                <#assign workfirst=1>
                                <#list problem as work>
                                    <tr>
                                    <#if paperfirst==1>
                                        <td class=edge>${work.papername}</td>
                                        <#assign paperfirst=0>
                                    <#else>
                                        <td class=edge></td>
                                    </#if>
                                    <#if workfirst==1>
                                        <td class=edge>
                                            <a href="./Problem?problemid=${work.idproblem?c}">
                                                <p>${work.idproblem?c}</p>
                                            </a>
                                        </td>
                                        <#assign workfirst=0>
                                    <#else>
                                        <td class=edge></td>
                                    </#if>
                                    <td class="edge">
                                        <#if work.problemlevel == 1>
                                            <p>☆</p>
                                        </#if>
                                        <#if work.problemlevel == 2>
                                            <p>☆☆</p>
                                        </#if>
                                        <#if work.problemlevel == 3>
                                            <p>☆☆☆</p>
                                        </#if>
                                        <#if work.problemlevel == 4>
                                            <p>☆☆☆☆</p>
                                        </#if>
                                    </td>

                                    <td class=edge>${work.startdate?time}</td>
                                    <td class=edge>${work.workdate?time}</td>
                                    <td class=edge>
                                    <#assign len=work.usedtime>
                                    <#if len==0>
                                        <#assign len=1>
                                    </#if>
                                    <#if work.workmark??>
                                        <#if work.workmark==0>
                                            <p class="edge" style="height: 20px; float:left; width:${len?c}0px;background-color:green">${work.usedtime?c}</p>
                                        <#else>
                                            <p class="edge" style="height: 20px; float:left; width:${len?c}0px;background-color:red">${work.usedtime?c}</p>
                                        </#if>
                                    <#else>
                                        <p class="edge" style="height: 20px; float:left; width:${len?c}0px;background-color:orange">${work.usedtime?c}</p>
                                    </#if>
                                    </td>
                                    <td>
                                    </td>
                                    </tr>
                                </#list>
                            </#list>
                    </#list>
                </#if>
            </table>
        </div>
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
        $( function() {
          $( "#tabs" ).tabs();
        } );
    </script>
</html>