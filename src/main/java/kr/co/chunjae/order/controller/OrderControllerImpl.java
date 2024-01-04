package kr.co.chunjae.order.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.chunjae.common.base.BaseController;
import kr.co.chunjae.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.chunjae.goods.vo.GoodsVO;
import kr.co.chunjae.order.service.OrderService;
import kr.co.chunjae.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController {
	@Autowired
	OrderService orderService;
	@Autowired
	OrderVO orderVO;
	
	@RequestMapping(value="/orderEachGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		String action=(String)session.getAttribute("action");
		//로그인 여부 체크
		//이전에 로그인 상태인 경우는 주문과정 진행
		//로그아웃 상태인 경우 로그인 화면으로 이동
		if(isLogOn==null || isLogOn==false){
			session.setAttribute("orderInfo", _orderVO);
			session.setAttribute("action", "/order/orderEachGoods.do");
			return new ModelAndView("redirect:/member/loginForm.do");
		}else{
			 if(action!=null && action.equals("/order/orderEachGoods.do")){
				orderVO=(OrderVO)session.getAttribute("orderInfo");
				session.removeAttribute("action");
			 }else {
				 orderVO=_orderVO;
			 }
		 }
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		List myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO);

		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberInfo);
		return mav;
	}
	
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap");
		List myOrderList=new ArrayList<OrderVO>();
		
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		for(int i=0; i<cart_goods_qty.length;i++){
			String[] cart_goods=cart_goods_qty[i].split(":");
			for(int j = 0; j< myGoodsList.size();j++) {
				GoodsVO goodsVO = myGoodsList.get(j);
				int goodsId = goodsVO.getGoodsId();
				if(goodsId==Integer.parseInt(cart_goods[0])) {
					OrderVO _orderVO=new OrderVO();
					String goods_title=goodsVO.getGoodsTitle();
					int goods_sales_price=goodsVO.getGoodsSalesPrice();
					String goods_fileName=goodsVO.getGoodsFileName();
					_orderVO.setGoodsId(goodsId);
					_orderVO.setGoodsTitle(goods_title);
					_orderVO.setGoodsSalesPrice(goods_sales_price);
					_orderVO.setGoodsFileName(goods_fileName);
					_orderVO.setOrderGoodsQty(Integer.parseInt(cart_goods[1]));
					myOrderList.add(_orderVO);
					break;
				}
			}
		}
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
	}	
	
	@RequestMapping(value="/payToOrderGoods.do" ,method = RequestMethod.POST)
	public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
		String member_id=memberVO.getMemberId();
		String orderer_name=memberVO.getMemberName();
		String orderer_hp = memberVO.getMemberHp1()+"-"+memberVO.getMemberHp2()+"-"+memberVO.getMemberHp3();
		List<OrderVO> myOrderList=(List<OrderVO>)session.getAttribute("myOrderList");
		
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO=(OrderVO)myOrderList.get(i);
			orderVO.setMemberId(member_id);
			orderVO.setOrdererName(orderer_name);
			orderVO.setReceiverName(receiverMap.get("receiver_name"));
			
			orderVO.setReceiverHp1(receiverMap.get("receiver_hp1"));
			orderVO.setReceiverHp2(receiverMap.get("receiver_hp2"));
			orderVO.setReceiverHp3(receiverMap.get("receiver_hp3"));
			orderVO.setDeliveryAddress(receiverMap.get("delivery_address"));
			orderVO.setDeliveryMessage(receiverMap.get("delivery_message"));
			orderVO.setDeliveryMethod(receiverMap.get("delivery_method"));
			orderVO.setGiftWrapping(receiverMap.get("gift_wrapping"));
			orderVO.setPayMethod(receiverMap.get("pay_method"));
			orderVO.setCardComName(receiverMap.get("card_com_name"));
			orderVO.setCardPayMonth(receiverMap.get("card_pay_month"));
			orderVO.setPayOrdererHpNum(receiverMap.get("pay_orderer_hp_num"));
			orderVO.setOrdererHp(orderer_hp);
			myOrderList.set(i, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
		}//end for
		
	    orderService.addNewOrder(myOrderList);
		mav.addObject("myOrderInfo",receiverMap);//OrderVO로 주문결과 페이지에  주문자 정보를 표시한다.
		mav.addObject("myOrderList", myOrderList);
		return mav;
	}
	

}
