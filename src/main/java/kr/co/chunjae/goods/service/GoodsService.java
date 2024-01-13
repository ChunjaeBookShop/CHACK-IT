package kr.co.chunjae.goods.service;

import java.util.List;
import java.util.Map;

import kr.co.chunjae.goods.vo.CommentVO;
import kr.co.chunjae.goods.vo.GoodsVO;

public interface GoodsService {
	
	public Map<String,List<GoodsVO>> listGoods() throws Exception;
	public Map goodsDetail(String _goodsId) throws Exception;
	
	public List<String> keywordSearch(String keyword) throws Exception;
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;

}
