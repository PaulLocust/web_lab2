
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.server.Row" %>

<!DOCTYPE html>
<html lang="ru-RU">

<head>
    <meta charset="UTF-8">
    <title>Лабораторная работа №2</title>
    <script src="static/js/jquery-3.7.1.min.js"></script>
    <script defer src="static/js/point.js"></script>
    <link rel="stylesheet" href="static/css/index.css">
    <link rel="icon" type="image/jpg" href="static/media/favicon.ico">
</head>

<body>
<div class="content-container">
    <header class="header">
        <div class="header-container">
            <div>Саранча Павел Александрович P3209</div>
            <div></div>
            <div>409517</div>
        </div>
    </header>
    <form action="/server/check" method="get" id="form">
        <main class="main">
            <div class="main__left-column">
                <div class="main__block" id="graph-container">
                    <%@include file="static/media/graph.svg" %>
                </div>
                <div class="main__block">
                    <div class="row">Параметры</div>
                    <div class="row">
                        <div>Выберете X:</div>
                        <div><input name="x" type="radio" value="2.0">2.0</div>
                        <div><input name="x" type="radio" value="1.5">1.5</div>
                        <div><input name="x" type="radio" value="1.0">1.0</div>
                        <div><input name="x" type="radio" value="0.5">0.5</div>
                        <div><input name="x" type="radio" value="0.0">0.0</div>
                        <div><input name="x" type="radio" value="-0.5">-0.5</div>
                        <div><input name="x" type="radio" value="-1.0">-1.0</div>
                        <div><input name="x" type="radio" value="-1.5">-1.5</div>
                        <div><input name="x" type="radio" value="-2.0">-2.0</div>
                    </div>

                    <div class="row">
                        <div>Выберете Y:</div>
                        <input name="y" id="y-input" type="text" placeholder="значение от -5 до 3" maxlength="7">
                    </div>

                    <div class="row">
                        <div>Выберите R:</div>
                        <div><input name="r" type="checkbox" value="1">1</div>
                        <div><input name="r" type="checkbox" value="2">2</div>
                        <div><input name="r" type="checkbox" value="3">3</div>
                        <div><input name="r" type="checkbox" value="4">4</div>
                        <div><input name="r" type="checkbox" value="5">5</div>
                    </div>
                </div>
                <button type="submit" class="main__block submit_button" style="margin-bottom: 15px;" id="submit">
                    Проверить
                </button>
            </div>
            <div>
                <div class="result-title">Результат</div>
                <div class="result-container">
                    <div style="border-top: 1px solid #000000;">X</div>
                    <div style="border-top: 1px solid #000000;">Y</div>
                    <div style="border-top: 1px solid #000000;">R</div>
                    <div style="border-top: 1px solid #000000;">Попал?</div>
                </div>
                <div class="result-container" id="result">
                    <% if (request.getServletContext().getAttribute("rows") != null) { %>
                    <% ArrayList<Row> array = (ArrayList<Row>) request.getServletContext().getAttribute("rows");%>
                    <% for (int index = array.size() - 1; index >= 0; index--) { %>
                    <div><%= array.get(index).getX() %></div>
                    <div><%= array.get(index).getY() %></div>
                    <div><%= array.get(index).getR() %></div>
                    <div><%= array.get(index).getResult() ? "<span style='color:green'>Да</span>" : "<span style='color:red'>Нет</span>" %></div>
                    <% } %>
                    <% } %>
                </div>
            </div>
        </main>
    </form>
</div>
<script>
    window.onload = function() {
        loadData();
        <% if (request.getServletContext().getAttribute("rows") != null) { %>
        <% ArrayList<Row> array = (ArrayList<Row>) request.getServletContext().getAttribute("rows");%>
        <% for (int index = array.size() - 1; index >= 0; index--) { %>
        drawPoint(
            <%= array.get(index).getX() %>,
            <%= array.get(index).getY() %>,
            <%= array.get(index).getR() %>,
            <%= array.get(index).getResult() %>
        );
        <% } %>
        <% } %>
    }
</script>
</body>

</html>

