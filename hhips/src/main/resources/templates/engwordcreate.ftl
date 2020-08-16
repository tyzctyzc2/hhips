<html>
<head>
	<meta charset="utf-8"/>
	<title>Create new word</title>
	<script type="text/javascript" src="../../jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="../../js/common.js"></script>
	<link href="../../css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
        <div>
		    <input class="bigFont" type="text" id="word" />
		    <button class="bigFont" type="button" onclick="search()">Search</button>
        </div>
        <div>
		    <textarea class="bigFont" cols="100" rows="14" type="text" id="explanation"></textarea>
		</div>
        <button class="bigFont" type="button" onclick="postWord()">Create Word</button>
    </body>
    <script>
        function search() {
            var word = $( "#word" ).val();
            $.ajax({
                type: "GET",
                url: "../../english/word?search=" + word,
                dataType : "json",
                processData: false,  // 注意：不要 process data
                contentType: "application/json",
                success: function(msg) {
                    console.log(msg);
                    if (msg.foundDuplicate == true) {
                        alert('duplicate word!!!!!\n'+msg.explanation);
                    }
                    $( "#explanation" ).val(msg.explanation);
                },
                fail: function(msg) {
                    console.log(msg);
                }
            })
        }
        function postWord() {
            var pData = {};
            pData.explanation = $( "#explanation" ).val();
            pData.word = $( "#word" ).val();

            console.log(JSON.stringify(pData));

            $.ajax({
                type: "POST",
                url: "../../english/word/create",
                dataType : "json",
                processData: false,  // 注意：不要 process data
                contentType: "application/json",
                data: JSON.stringify(pData),
                success: function(msg) {
                    console.log(msg);
                    toastFunction(msg);
                    $( "#word" ).val('');
                    $( "#explanation" ).val('');
                },
                fail: function(msg) {
                    console.log(msg);
                }
            })
        }
    </script>
</html>