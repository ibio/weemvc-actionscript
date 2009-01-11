﻿import utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.*;
import org.weemvc.as2.view.BaseView;
import application.model.vo.ImageVO;
import application.actions.ShowImageCommand;

class application.view.ThumbList extends BaseView {
	public static var NAME:String = "thumbList";
	private var m_panel:MovieClip;
	private var m_playList:Array;
	private var m_arrowYList:Array = [0, 62.5, 125.0, 187.5];
	private var m_tweenY:Tween;
	
	public function ThumbList(target:MovieClip) {
		m_panel = target;
	}
	
	public function init(playList:Array):Void {
		m_playList = playList;
		buildThumbs();
		//默认是选中第1张
		m_panel["mc_thumb" + 0].isSelected = true;
		sendNotification(ShowImageCommand.NAME, 0);
	}
	
	private function buildThumbs():Void {
		for (var i = 0; i < m_playList.length; i++) {
			var imageData:ImageVO = m_playList[i];
			m_panel["mc_thumb" + i].setData(imageData.title, imageData.subtitle);
			m_panel["mc_thumb" + i].onRelease = Delegate.create(this, onThumbClick, {index:i});
		}
	}
	
	private function onThumbClick(obj:Object):Void {
		//清除之前的
		for (var i = 0; i < m_playList.length; i++) {
			m_panel["mc_thumb" + i].isSelected = false;
		}
		m_panel["mc_thumb" + obj.index].isSelected = true;
		//
		var newY:Number = m_arrowYList[obj.index];
		try {
			m_tweenY.stop();
		}catch (e:Error) {
			trace("ThumbList::onThumbClick_handler:" + e.message);
		}
		m_tweenY = new Tween(m_panel.mc_arrow, "_y", Strong.easeOut, m_panel.mc_arrow._y, newY, 1.5, true);
		//trace("当前点击：", e.currentTarget.index);
		sendNotification(ShowImageCommand.NAME, obj.index);
	}
}