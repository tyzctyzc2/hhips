<html>
<head>
	<meta charset="utf-8"/>
	<#if showanswer == true>
	    <title>${name}</title>
    <#else>
        <title>${name} Test</title>
    </#if>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="./js/common.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
	    <h>${name}</h>
	    <table>
            <#list 0..max as i>
                <tr>
                    <#if showanswer == true>
                        <td style="border: 1px; border-style: solid;" class="oneLineText">
                            ${words[i].idword}_${words[i].word}
                        </td>
                    <#else>
                        <td style="border: 1px; border-style: solid;">
                            ${words[i].idword}_${words[i].word?substring(0,1)}____________
                        </td>
                    </#if>
                    <#if showanswer == true>
                        <td style="border: 1px; border-style: solid;">
                            ${words[i].explanation}
                        </td>
                    <#else>
                        <td style="border: 1px; border-style: solid;">
                            ${words[i].meaning}
                        </td>
                    </#if>
                </tr>
            </#list>
		</table>
    </body>
</html>