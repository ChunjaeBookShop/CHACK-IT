package kr.co.chunjae.order.vo;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.sql.Date;


@Getter
@Setter
@Component("orderVO")
public class OrderVO {
	private int orderSeqNum;
	private String memberId;
	private int orderId;
	private int goodsId;
	private String goodsTitle;
	private int goodsSalesPrice;
	private int totalGoodsPrice;
	private int cartGoodsQty; //장바구니에 담긴 제품 수
	private int orderGoodsQty; //최종 주문  제품 수
	private String ordererName;
	private String receiverName;
	private String receiverHp1;
	private String receiverHp2;
	private String receiverHp3;
	private String deliveryAddress;
	private String deliveryMessage;
	private String deliveryMethod;
	private String giftWrapping;
	private String payMethod;
	private String cardComName;
	private String cardPayMonth;
	private String payOrdererHpNum; //휴대폰 결제 전화번호
	private Date payOrderTime;
	private String deliveryState;  //현재 주문 상품 배송 상태
	
	private String finalTotalPrice;
	private int goodsQty;
	private String goodsFileName;
	private String ordererHp;

}
