<html>
    <head>
        <meta charset="utf-8"/>
        <title>Chapter List</title>
        <link href="./jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
        <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
        <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="./jqueryui/jquery-ui.js"></script>

        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/series-label.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
    </head>
    <body>
        <#include "/header.ftl">
        <div    style = text-align: right;>
            <p>Date: <input type="text" id="datepicker"></p>
        </div>
        <h1>${wantday}</h1>
        <div id="tabs">
            <ul>
                <li><a href="#summary">Summary</a></li>
                <li><a href="#timesummary">Time Summary</a></li>
                <li><a href="#papersummary">Paper Summary</a></li>
                <li><a href="#historysummary">History Summary</a></li>
            </ul>
            <div id="summary">
                <p>总计：</p>
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
                <p>按卷卷综合：</p>
                <table>
                    <tr>
                        <th class=edge>卷卷</th>
                        <th class=edge>总题目</th>
                        <th class=edge>一击命中</th>
                        <th class=edge>待改正</th>
                        <th class=edge>总时间</th>
                    </tr>
                    <#list papersummary as onepaper>
                    <tr>
                        <td class=edge><a href="./Problem?showanswer=1&paperid=${onepaper.idpaper}" style="text-decoration: none"><p>${onepaper.paperName}</p></a></td>
                        <td class=edge>${onepaper.totalWorkedProblem}</td>
                        <td class=edge>${onepaper.oneTimeCorrectProblem}</td>
                        <td class=edge>${onepaper.waitToFixProblem}</td>
                        <td class=edge>${onepaper.totalWorkTime}</td>
                    </tr>
                    </#list>
                </table>
                <p>计分：</p>
                <h1>${todayScore}</h1>
                <div>基准分</div>
                <div>一星+2，没做对/放弃-2</div>
                <div>二星+4，没做对/放弃-2</div>
                <div>三星+10</div>
                <div>四星+14</div>
                <div>错次数：</div>
                <div>一星-1</div>
                <div>二星-1</div>
                <div>三星-1</div>
                <div>四星有错不扣分，无错一次对+1</div>
                <div>时间：</div>
                <div>一星：3分钟以下+1，10分钟以上-1</div>
                <div>二星：5分钟以下+1，15分钟以上-1</div>
                <div>三星：10分钟以下+1，20分钟以上-1</div>
                <div>四星：30分钟以下+1</div>
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
            <div id="historysummary">
                <div id="container"></div>
            </div>
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

        Highcharts.chart('container', {
            chart: {
                type: 'spline'
            },
            title: {
                text: 'History'
            },
            subtitle: {
                text: 'Maxi Past 60 Days'
            },
            xAxis: {
                type: 'datetime',
                dateTimeLabelFormats: { // don't display the dummy year
                    month: '%e. %b',
                    year: '%b'
                },
                title: {
                    text: 'Date'
                }
            },
            yAxis: {
                title: {
                    text: 'Score'
                },
                min: 0
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x:%e. %b}: {point.y:.0f} '
            },

            plotOptions: {
                spline: {
                    marker: {
                        enabled: true
                    }
                }
            },

            colors: ['#F6C', '#6CF', '#06C', '#036', '#000'],

            // Define the data points. All series have a dummy year
            // of 1970/71 in order to be compared on the same x axis. Note
            // that in JavaScript, months start at 0 for January, 1 for February etc.
            series: [{
                name: "Score",
                data: [
                    ${scoreHis}
                ]
            }, {
                name: "User Time",
                data: [
                    ${usedTimeHis}
                ]
            }, {
                name: "Problem",
                data: [
                    ${problemHis}
                ]
            }]
        });
    </script>
</html>