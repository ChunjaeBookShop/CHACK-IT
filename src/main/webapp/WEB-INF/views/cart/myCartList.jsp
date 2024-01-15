<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="myCartList" value="${cartMap.myCartList}" />
<c:set var="myGoodsList" value="${cartMap.myGoodsList}" />

<c:set var="totalGoodsNum" value="0" /> <!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 -->
<fmt:parseNumber value="0" var="maxDeliveryPrice" type="number" /> <!-- 가장 높은 배송비를 가진 책의 배송비 초기화-->
<c:set var="totalDiscountedPrice" value="0" /> <!-- 총 할인금액 -->

<head>
    <script type="text/javascript">
        function calcGoodsPrice(bookPrice, obj, index) {
            var totalPrice, final_total_price, totalNum;
            var goods_qty = document.getElementById("select_goods_qty");
            alert("총 상품금액" + goods_qty.value);
            var p_totalNum = document.getElementById("p_totalNum");
            var p_totalPrice = document.getElementById("p_totalPrice");
            var p_final_totalPrice = document.getElementById("p_final_totalPrice");
            var h_totalNum = document.getElementById("h_totalNum");
            var h_totalPrice = document.getElementById("h_totalPrice");
            var h_totalDelivery = document.getElementById("h_totalDelivery");
            var h_final_total_price = document.getElementById("h_final_totalPrice");
            if (obj.checked == true) {
                alert("체크 했음")

                totalNum = Number(h_totalNum.value) + Number(goods_qty.value);
                alert("1111totalNum:" + totalNum);
                totalPrice = Number(h_totalPrice.value) + Number(goods_qty.value * bookPrice);
                alert("2222totalPrice:" + totalPrice);
                final_total_price = totalPrice + Number(h_totalDelivery.value);
                alert("3333final_total_price:" + final_total_price);

            } else {
                alert("555h_totalNum.value:" + h_totalNum.value);
                totalNum = Number(h_totalNum.value) - Number(goods_qty.value);
                alert("666totalNum:" + totalNum);
                totalPrice = Number(h_totalPrice.value) - Number(goods_qty.value) * bookPrice;
                alert("777totalPrice=" + totalPrice);
                final_total_price = totalPrice - Number(h_totalDelivery.value);
                alert("888final_total_price:" + final_total_price);
            }

            h_totalNum.value = totalNum;

            h_totalPrice.value = totalPrice;
            h_final_total_price.value = final_total_price;

            p_totalNum.innerHTML = totalNum;
            p_totalPrice.innerHTML = totalPrice;
            p_final_totalPrice.innerHTML = final_total_price;
        }


        function changefn(goods_id) {
            var cart_goods_qty = document.getElementById("slt" + goods_id);
            var value = (cart_goods_qty.options[cart_goods_qty.selectedIndex].value);
            return value;
        }
        function modify_cart_qty(goods_id) {
            let cart_goods_qty = changefn(goods_id);

            //alert("cart_goods_qty:"+cart_goods_qty);
            //console.log(cart_goods_qty);
            $.ajax({
                type: "post",
                async: false, //false인 경우 동기식으로 처리한다.
                url: "${contextPath}/cart/modifyCartQty.do",
                data: {
                    goods_id: goods_id,
                    cart_goods_qty: cart_goods_qty
                },

                success: function (data, textStatus) {
                    //alert(data);
                    if (data.trim() == 'modify_success') {
                        alert("수량을 변경했습니다!!");
                    } else {
                        alert("다시 시도해 주세요!!");
                    }

                },
                error: function (data, textStatus) {
                    alert("에러가 발생했습니다." + data);
                },
                complete: function (data, textStatus) {
                    //alert("작업을완료 했습니다");

                }
            }); //end ajax
            //수량 수정 시 reload 하여 즉시 총 수량 변경
            location.reload();

        }

        function deleteCartGoods(cartId) {
            // 삭제 폼에 cartId 설정 후 서브밋
            var deleteForm = document.getElementById("deleteForm");
            var cartIdToDelete = document.getElementById("cartIdToDelete");
            cartIdToDelete.value = cartId;
            deleteForm.submit();

        }


        function fn_order_each_goods(goods_id, goods_title, goods_sales_price, fileName, goods_delivery_price) {
            var total_price, final_total_price, cart_goods_qty;
            var cart_goods_qty_element = document.getElementById("slt" + goods_id);
            var _order_goods_qty = parseInt(cart_goods_qty_element.value);

            var formObj = document.createElement("form");
            var i_goods_id = document.createElement("input");
            var i_goods_title = document.createElement("input");
            var i_goods_sales_price = document.createElement("input");
            var i_fileName = document.createElement("input");
            var i_order_goods_qty = document.createElement("input");
            var i_goods_delivery_price = document.createElement("input")

            i_goods_id.name = "goodsId";
            i_goods_title.name = "goodsTitle";
            i_goods_sales_price.name = "goodsSalesPrice";
            i_fileName.name = "goodsFileName";
            i_order_goods_qty.name = "orderGoodsQty";
            i_goods_delivery_price.name = "goodsDeliveryPrice";

            i_goods_id.value = goods_id;
            i_order_goods_qty.value = _order_goods_qty;
            i_goods_title.value = goods_title;
            i_goods_sales_price.value = goods_sales_price;
            i_fileName.value = fileName;
            i_goods_delivery_price.value = goods_delivery_price;

            formObj.appendChild(i_goods_id);
            formObj.appendChild(i_goods_title);
            formObj.appendChild(i_goods_sales_price);
            formObj.appendChild(i_fileName);
            formObj.appendChild(i_order_goods_qty);
            formObj.appendChild(i_goods_delivery_price);

            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/order/orderEachGoods.do";
            formObj.submit();
        }

        function fn_order_all_cart_goods() {
            //	alert("모두 주문하기");
            var order_goods_qty;
            var order_goods_id;
            var goods_delivery_price;
            var objForm = document.frm_order_all_cart;
            var cart_goods_qty = objForm.cart_goods_qty;
            var h_order_each_goods_qty = objForm.h_order_each_goods_qty;
            var checked_goods = objForm.checked_goods;
            var length = checked_goods.length;


            //alert(length);
            if (length > 1) {
                for (var i = 0; i < length; i++) {
                    if (checked_goods[i].checked == true) {
                        order_goods_id = checked_goods[i].value;
                        goods_delivery_price = checked_goods[i].value;
                        order_goods_qty = changefn(order_goods_id);
                        cart_goods_qty[i].value = "";
                        cart_goods_qty[i].value = order_goods_id + ":" + order_goods_qty;
                    }
                }
            } else {
                order_goods_qty = changefn(order_goods_id);
                cart_goods_qty.value = order_goods_id + ":" + order_goods_qty;
                //alert(select_goods_qty.value);
            }

            objForm.method = "post";
            objForm.action = "${contextPath}/order/orderAllCartGoods.do";
            objForm.submit();
        }

    </script>
</head>

<body>
<table class="list_view">
    <tbody align=center>
    <tr style="background:#33ff00">
        <td class="fixed">구분</td>
        <td colspan=2 class="fixed">상품명</td>
        <td>판매가</td>
        <td></td>
        <td>수량</td>
        <td>합계</td>
        <td>주문</td>
    </tr>

    <form id="deleteForm" action="${contextPath}/cart/removeCartGoods.do" method="post">
        <input type="hidden" id="cartIdToDelete" name="cart_id" value="" />
    </form>

    <c:choose>
    <c:when test="${ empty myCartList }">
        <tr>
            <td colspan=8 class="fixed">
                <strong>장바구니에 상품이 없습니다.</strong>
            </td>
        </tr>
    </c:when>
    <c:otherwise>

    <tr>

        <form name="frm_order_all_cart">
            <c:forEach var="item" items="${myGoodsList }" varStatus="cnt">
                <c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cartGoodsQty }" />
                <c:set var="cart_id" value="${myCartList[cnt.count-1].cartId }" />
                <c:set var="goods_delivery_price" value="${myGoodsList[cnt.count-1].goodsDeliveryPrice}" />
            <td>
                <input type="checkbox" name="checked_goods" checked value="${item.goodsId }"
                       onClick="calcGoodsPrice(${item.goodsSalesPrice },this)">
            </td>
            <td class="goods_image">
                <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">
                    <img width="75" alt=""
                         src="${contextPath}/thumbnails.do?goods_id=${item.goodsId }&fileName=${item.goodsFileName }" />
                </a>
            </td>
            <td>
                <h2>
                    <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">${item.goodsTitle
                            }</a>
                </h2>
            </td>
            <td class="price">${item.goodsPrice }원</td>
            <td>
            </td>
            <td>
                <select style="width: 60px;" id="slt${item.goodsId}"
                        onchange="changefn(${item.goodsId})">
                    <c:forEach var="qty" begin="1" end="5">
                        <option value="${qty}" <c:if test="${cart_goods_qty eq qty}">selected</c:if>
                        >${qty}</option>
                    </c:forEach>
                </select>
                <input type="hidden" id="cart_goods_qty" name="cart_goods_qty">
                <a
                        href="javascript:modify_cart_qty('${item.goodsId}','${item.goodsSalesPrice}','${cnt.count-1}');">
                    <img width=25 alt="" src="${contextPath}/resources/image/btn_modify_qty.jpg">
                </a>
            </td>
            <td>
                <strong>
                    <fmt:formatNumber value="${item.goodsPrice*cart_goods_qty}" type="number"
                                      var="total_sales_price" />
                        ${total_sales_price}원
                </strong>
            </td>
            <td>
                <a href="javascript:fn_order_each_goods('${item.goodsId }','${item.goodsTitle }','${item.goodsPrice}','${item.goodsFileName}','${item.goodsDeliveryPrice}');">
                    <img width="75" alt="" src="${contextPath}/resources/image/btn_order.jpg">
                </a><br>
                <a href="javascript:void(0);" onclick="deleteCartGoods('${cart_id}');">
                    <img width="75" alt="" src="${contextPath}/resources/image/btn_delete.jpg">
                </a>
            </td>

    </tr>
    <c:set var="totalGoodsPrice" value="${totalGoodsPrice+item.goodsPrice*cart_goods_qty }" />
    <c:set var="totalGoodsNum" value="0" />

    <c:forEach var="item2" items="${myGoodsList}" varStatus="cnt">
        <c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cartGoodsQty}" />
        <c:set var="totalGoodsNum" value="${totalGoodsNum + cart_goods_qty}" />
    </c:forEach>
    <fmt:parseNumber value="${item.goodsDeliveryPrice}" var="currentDeliveryPrice" type="number" />
        <!-- 현재값이 최대값보다 크면 최대값 갱신 -->
        <c:if test="${currentDeliveryPrice > maxDeliveryPrice}">
            <c:set var="maxDeliveryPrice" value="${currentDeliveryPrice}" />
        </c:if>
    </c:forEach>

    </tbody>
</table>

<div class="clear"></div>
</c:otherwise>
</c:choose>
<br>
<br>

<table width=80% class="list_view" style="background:#cacaff">
    <tbody>
    <tr align=center class="fixed">
        <td class="fixed">총 상품수 </td>
        <td>총 상품금액</td>
        <td> </td>
        <td>총 배송비</td>
        <td> </td>
        <td>최종 결제금액</td>
    </tr>
    <tr cellpadding=40 align=center>
        <td id="">
            <p id="p_totalGoodsNum">${totalGoodsNum}개 </p>
            <input id="h_totalGoodsNum" type="hidden" value="${totalGoodsNum}" />
        </td>
        <td>
            <p id="p_totalGoodsPrice">
                <fmt:formatNumber value="${totalGoodsPrice}" type="number" var="total_goods_price" />
                ${total_goods_price}원
            </p>
            <input id="h_totalGoodsPrice" type="hidden" value="${totalGoodsPrice}" />
        </td>
        <td>
            <img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">
        </td>
        <td>
            <p id="p_totalDeliveryPrice">${maxDeliveryPrice }원 </p>
            <input id="h_totalDeliveryPrice" type="hidden" name="maxDeliveryPrice" value="${maxDeliveryPrice}" />
        </td>
        <td>
            <img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
        </td>
        <td>
            <p id="p_final_totalPrice">
                <fmt:formatNumber value="${totalGoodsPrice+maxDeliveryPrice}" type="number"
                                  var="total_price" />
                ${total_price}원
            </p>
            <input id="h_final_totalPrice" type="hidden"
                   value="${totalGoodsPrice+maxDeliveryPrice}" />
        </td>
    </tr>
    </tbody>
</table>
<center>
    <br><br>
    <a href="javascript:fn_order_all_cart_goods()">
        <img width="75" alt="" src="${contextPath}/resources/image/btn_order_final.jpg">
    </a>
    <a href="#">
        <img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
    </a>
    <center>
        </form>
    </center>
</center>
</body>