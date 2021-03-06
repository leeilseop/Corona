<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
     <!-- 합쳐지고 최소화된 최신 CSS -->
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
 
     <!-- 구글차트 -->
     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

</head>
 <body>
 <div class="container">
        <div class="row">
            <div id="sdate" class="bg-info img-rounded">
                 
            </div>
        </div>
    </div>
    
    <div class="container bg-warning" style="margin-top: 30px;">
        <div id="sumdate" class="row w-75">
             </div>
        </div>
    
       
           <div id="clist" class="container" style="margin-top: 30px; background-color: gray;">
           <div class="row" style="margin-top: 10px;">
               <div class="col-xs-3">
                지역
               </div>
               <div class="col-xs-3">오늘확진자</div>
               <div class="col-xs-3">사망자</div>
               <div class="col-xs-3">10만명당 확진자</div>
            </div>
           </div>
    <script>
var deathCnt = null; //사망자 수
var defCnt = null;   //확진자 수
var gubun = null;    //시도명(한글)
var incDec = null;   //전일대비 증감수
var localOccCnt = null; // 지역발생 수
var overFlowCnt = null; //해외유입 수
var stdDay = null; //기준일
var qurRate = null; //10만명당 발생률
$(document).ready(function(){
                $.ajax({
                    type: "GET",
                    url: "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=aVNkmiScbNl2jQYP3QpAvPv2IwihrSkC6rbFWw0LtFboUfJy8tLQH6h2QBGU98jNGDhqTyBoWWcyC%2BjWxffgJg%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20220330&endCreateDt=20220330",
                    dataType: "xml",
                    success: function (xml) {
                        // Parse the xml file and get data
                        deathCnt = xml.getElementsByTagName("deathCnt");
                        defCnt = xml.getElementsByTagName("defCnt");
                        gubun = xml.getElementsByTagName("gubun");
                        incDec = xml.getElementsByTagName("incDec");
                        localOccCnt = xml.getElementsByTagName("localOccCnt");
                        overFlowCnt = xml.getElementsByTagName("overFlowCnt");
                        stdDay = xml.getElementsByTagName("stdDay");
                        qurRate = xml.getElementsByTagName("qurRate");
                        console.log(stdDay[0].childNodes[0].nodeValue);
                    for(var i=0;i<gubun.length;i++){
                        c = `
                        <div class="row" style="margin-top: 20px;">
                        <div class="col-xs-3 text-center">${gubun[i].childNodes[0].nodeValue}</div>
                        <div class="col-xs-3 text-center">${incDec[i].childNodes[0].nodeValue}</div>
                        <div class="col-xs-3 text-center">${deathCnt[i].childNodes[0].nodeValue}</div>
                        <div class="col-xs-3 text-center">${qurRate[i].childNodes[0].nodeValue}</div>
                        </div>
                        `;
                        $('#clist').append(c);
                    }
                     a =  `
                    <h1 class="text-uppercase text-center">${stdDay[0].childNodes[0].nodeValue} 기준 전국 코로나19 발생현황</h1>
                    `; 
                    $('#sdate').append(a);

                    b = `
                    <div class="col-md-3">
                    <div class="card border-info mx-sm-1 p-3">
                        <div class="card border-info shadow text-info p-3 my-card" ><span class="fa fa-car" aria-hidden="true"></span></div>
                        <div class="text-danger text-center mt-3"><h4>전국 총 확진자</h4></div>
                        <div class="text-danger text-center mt-2"><h1>${defCnt[18].childNodes[0].nodeValue}</h1></div>
                    </div>
                </div>

 <div class="col-md-3">
                    <div class="card border-danger mx-sm-1 p-3">
                        <div class="card border-danger shadow text-danger p-3 my-card" ><span class="fa fa-heart" aria-hidden="true"></span></div>
                        <div class="text-danger text-center mt-3"><h4>전일대비 증감수</h4></div>
                        <div class="text-danger text-center mt-2"><h1>${incDec[18].childNodes[0].nodeValue}</h1></div>
                    </div>
                </div>


                <div class="col-md-3">
                    <div class="card border-success mx-sm-1 p-3">
                        <div class="card border-success shadow text-success p-3 my-card"><span class="fa fa-eye" aria-hidden="true"></span></div>
                        <div class="text-info text-center mt-3"><h4>전국 총 사망자</h4></div>
                        <div class="text-info text-center mt-2"><h1>${deathCnt[18].childNodes[0].nodeValue}</h1></div>
                    </div>
                </div>
               
                <div class="col-md-3">
                    <div class="card border-warning mx-sm-1 p-3">
                        <div class="card border-warning shadow text-warning p-3 my-card" ><span class="fa fa-inbox" aria-hidden="true"></span></div>
                        <div class="text-warning text-center mt-3"><h4>10만명당 발생률</h4></div>
                        <div class="text-warning text-center mt-2"><h1>${qurRate[18].childNodes[0].nodeValue}</h1></div>
                    </div>
                </div>
                    `;
                    $('#sumdate').append(b);
                      
                      
                      
                       /*  $(xml).find("item").each(function(){
                            $("#gname").html($(this).find("name").text());
                            $(this).find("member").each(function(i){
                                if (i != 0) { $("#members").append(", "); }
                                $("#members").append($(this).text());
                            });
                            $(this).find("album").each(function(){
                                $("#albums").append("<li>" + $(this).attr("order") +
                                    ": " + $(this).text() + "</li>\n");
                            });
                        }); */
                    }
                });
            });

    </script>
  </body>
</html>