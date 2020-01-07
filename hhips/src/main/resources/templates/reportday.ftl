<html>
    <head>
        <meta charset="utf-8"/>
        <title>战绩</title>
        <link href="./jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
        <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
        <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="./jqueryui/jquery-ui.js"></script>
        <script type="text/javascript" src="./js/common.js"></script>

        <script type="text/javascript" src="./chart/highcharts.js"></script>
        <script type="text/javascript" src="./chart/series-label.js"></script>
        <script type="text/javascript" src="./chart/exporting.js"></script>
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
                <li><a href="#starhis">🌟Star🌟</a></li>
            </ul>
            <div id="starhis">
                <h1>History：</h1>
                <table class="dmmtable">
                    <tr>
                        <th>时间</th>
                        <th>Balance</th>
                        <th>备注</th>
                    </tr>
                    <#list startHis as onechange>
                        <tr>
                            <td>${onechange.changedate}</td>
                            <td>${onechange.changebalance}</td>
                            <td>${onechange.changenote}</td>
                        </tr>
                    </#list>
                </table>
                <h1>Total: ${totalBalance}</h1>
            </div>
            <div id="summary">
                <h1>总计：</h1>
                <table class="dmmtable">
                    <tr>
                        <th>类别</th>
                        <th>总时间</th>
                        <th>次数</th>
                        <th>Avg.</th>
                    </tr>
                    <tr>
                        <td>正确</td>
                        <td>${totalCorrectUsedTime}</td>
                        <td>${totalCorrectTime}</td>
                        <td>${avgCorrect}</td>
                    </tr>
                    <tr>
                        <td>错误</td>
                        <td>${totalWrongUsedTime}</td>
                        <td>${totalWrongTime}</td>
                        <td>${avgWrong}</td>
                    </tr>
                    <tr>
                        <td>未知</td>
                        <td>${totalUnknownUsedTime}</td>
                        <td>${totalUnknownTime}</td>
                        <td>${avgUnknown}</td>
                    </tr>
                    <tr>
                        <td>总计</td>
                        <td>${totalUsedTime}</td>
                        <td>${totalTimes}</td>
                        <td>${avgTotal}</td>
                    </tr>
                </table>
                <h1>按卷卷综合：</h1>
                <table class="dmmtable">
                    <tr>
                        <th>卷卷</th>
                        <th>总题目</th>
                        <th>一击命中</th>
                        <th>待改正</th>
                        <th>总时间</th>
                    </tr>
                    <#list papersummary as onepaper>
                    <tr>
                        <td><a href="./Problem?showanswer=1&paperid=${onepaper.idpaper}" style="text-decoration: none"><p>${onepaper.paperName}</p></a></td>
                        <td>${onepaper.totalWorkedProblem}</td>
                        <td>${onepaper.oneTimeCorrectProblem}</td>
                        <td>${onepaper.waitToFixProblem}</td>
                        <td>${onepaper.totalWorkTime}</td>
                    </tr>
                    </#list>
                </table>
                <p>计分：</p>
                <h1>${todayScore}</h1>
                <p>🌟🌟🌟本月星星🌟🌟🌟：</p>
                <h1 class="right">${monthStar}</h1>
                <p>◉◉◉本月鸡蛋◉◉◉：</p>
                <h1 class="wrong">${monthEgg}</h1>
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

            <table id="timesummary" class="dmmtable">
                <#if maxseg != -1>
                    <#list 0..maxseg as i>
                        <tr>
                            <td style="white-space: nowrap;">${segworks[i].startdate?time}</td>
                            <td>
                                <#assign len=segworks[i].usedtime>
                                <#if len==0>
                                    <#assign len=1>
                                </#if>
                                <#if (len > 120)>
                                    <#assign len=120>
                                </#if>
                                <#if segworks[i].workmark != 0>
                                <p style="height: 20px; float:left; width:${len?c}0px;background-color:green">${segworks[i].usedtime?c}</p>
                                <#else>
                                <p style="height: 20px; float:left; width:${len?c}0px;background-color:red">${segworks[i].usedtime?c}</p>
                                </#if>
                            </td>
                        </tr>
                    </#list>
                </#if>
            </table>
            <table id="papersummary" class="dmmtable">
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
                                        <td><a href="./Problem?showanswer=1&paperid=${work.idpaper}" style="text-decoration: none"><p>${work.papername}</p></a></td>
                                        <#assign paperfirst=0>
                                    <#else>
                                        <td></td>
                                    </#if>
                                    <#if workfirst==1>
                                        <td>
                                            <a href="./Problem?problemid=${work.idproblem?c}">
                                                <p>${work.idproblem?c}</p>
                                            </a>
                                        </td>
                                        <#assign workfirst=0>
                                    <#else>
                                        <td></td>
                                    </#if>
                                    <td >${work.problemindex}</td>
                                    <td>
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
                                    <td >${work.modulename}</td>
                                    <td >${work.startdate?time}</td>
                                    <td >${work.workdate?time}</td>
                                    <td >
                                    <#assign len=work.usedtime>
                                    <#if len==0>
                                        <#assign len=1>
                                    </#if>
                                    <#if work.workmark??>
                                        <#if work.workmark==0>
                                            <p  style="height: 20px; float:left; width:${len?c}0px;background-color:green">${work.usedtime?c}</p>
                                        <#else>
                                            <p style="height: 20px; float:left; width:${len?c}0px;background-color:red">${work.usedtime?c}</p>
                                        </#if>
                                    <#else>
                                        <p style="height: 20px; float:left; width:${len?c}0px;background-color:orange">${work.usedtime?c}</p>
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

            colors: ['#80FF00', '#00FFFF', '#8000FF', '#036', '#000'],

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
                name: "Problem * 10",
                data: [
                    ${problemHis}
                ]
            }]
        });
    </script>
</html>