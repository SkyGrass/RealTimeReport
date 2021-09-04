<%@ Page Title="主页" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Report.aspx.cs" Inherits="RealTimeReport.Report" %>


<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    

    <div id="head">
        <h1 id="title" class="title"><%:PageTitle %></h1>
    </div>
    <div id="body" class="body">
    </div>
    <div id="foot" class="foot">
        <h5 class="left"><span id="msg">5秒后开始刷新...</span></h5>
        <h5 class="right">倒计时刷新:<span id="time" style="color: red"></span>秒</h5>
    </div>

    <script>    
        var offset = 3;
        var interval = Number("<%=Interval%>");;
        var _interval = Number("<%=Interval%>");;
        var titleHeight = 30;
        var timer = {};
        var groups = Number("<%=Cols%>");
        var isRuning = false
        var columns = [
            {
                key: "cInvCode",
                lable: "编码"
            },
            {
                key: "cInvName",
                lable: "名称"
            },
            {
                key: "iQuantity",
                lable: "库存量"
            },
        ]

        function randomRgbColor() {
            var r = Math.floor(Math.random() * 256);
            var g = Math.floor(Math.random() * 256);
            var b = Math.floor(Math.random() * 256);
            return `rgb(${r},${g},${b})`;
        }

        function init() {
            var headHeight = $('#head').height();
            var footHeight = $('#foot').height();
            var windHeight = $(window).height() - offset;
            var bodyHeight = windHeight - headHeight - footHeight;
            $('#body').height(bodyHeight);
            $('#body').empty();
            for (var i = 0; i < groups; i++) {
                var dom = document.createElement('div');
                $(dom).width((100 / groups) + '%')
                $(dom).height(bodyHeight)
                $(dom).css('background-color', '#333')
                $(dom).css('margin', '0px 5px 0px 5px')
                $(dom).append(buildTable(i))
                $('#body').append(dom);
                $('#time').html('-')
            }
        }

        function buildTable(index) {
            var table = document.createElement('table');
            $(table).attr('id', "table_" + index)
            var tableHeader = document.createElement('thead');
            var tr = document.createElement('tr');
            $(tr).height(titleHeight);
            $(tr).css('miniHeight', titleHeight);
            columns.forEach(function (column) {
                var td = document.createElement('td');
                $(td).html(column.lable)
                $(tr).append(td)
            })
            $(tableHeader).append(tr)
            $(table).append(tableHeader)
            return table;
        }

        function fillTable(index, source, countEveryGroup) {
            var table = $("#table_" + index)

            var bodyHeight = $('#body').height()
            var trHeight = (bodyHeight - titleHeight) / countEveryGroup;

            if (Array.isArray(source)) {
                source.forEach(function (row) {
                    var tr = document.createElement('tr');
                    $(tr).height(trHeight);
                    $(tr).addClass('data')
                    $(tr).css('miniHeight', trHeight);
                    columns.forEach(function (_column) {
                        var td = document.createElement('td');
                        $(td).html(row[_column.key])
                        $(tr).append(td)
                    })
                    $(table).append(tr)
                })
            }
        }

        function fetch() {
            $.getJSON("./proxy.ashx", function (result) {
                $('.data').remove();
                var list = result.data;
                var msg = result.msg;
                var state = result.state;
                if (state == "success") {
                    var count = list.length;
                    var countEveryGroup = Math.ceil(count / groups);
                    for (var i = 0; i < groups; i++) {
                        window['data_' + i] = list.slice(countEveryGroup * i, countEveryGroup * (1 + i));
                        fillTable(i, window['data_' + i], countEveryGroup)
                    }

                    $('.data').css('fontSize', '<%=FontSize%>px')
                    if (Object.keys(timer).length <= 0) {
                        isRuning = true;
                        timer = setInterval(function () {
                            if (interval == 0) {
                                interval = _interval;
                                $('.data').remove();
                                clearInterval(timer)
                                fetch();
                            } else if (_interval / interval == 2) {
                                $('#msg').html("等待查询...")
                                interval--;
                            } else {
                                interval--;
                            }
                            $('#time').html(interval)
                        }, 1000);
                    }
                }
                $('#msg').html(msg)
            });
        }

        window.onresize = function (e) {
            init();
        }

        window.onload = function () {
            setTimeout(function () {
                fetch();
            }, 5000)
        }

        init();


    </script>
</asp:Content>
