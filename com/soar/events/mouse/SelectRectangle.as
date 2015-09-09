package com.soar.events.mouse {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class SelectRectangle extends Sprite {
		
		private var targetPoint:Point; //目標點
		private var rec:Rectangle; //選擇框的矩形對像
		private var $selectInfo:selectInfo;
		private var copyRect:Rectangle;
		private var copyPoint:Point = new Point(1, 0);
		private var patternLength:Number;
		
		public function SelectRectangle(stag:DisplayObject):void {
			stag.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stag.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			$selectInfo = new selectInfo();
			addChild($selectInfo);
		}
		
		private function mouseDownHandler(evt:MouseEvent):void {
			targetPoint = new Point(evt.currentTarget.mouseX, evt.currentTarget.mouseY);
			$selectInfo.upDatePoint(targetPoint);
			evt.currentTarget.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler)
		}
		
		private function mouseMoveHandler(evt:MouseEvent):void {
			var recWidth:int = evt.currentTarget.mouseX - targetPoint.x;
			var recHeight:int = evt.currentTarget.mouseY - targetPoint.y;
			$selectInfo.upDateRect(recWidth, recHeight);
			
			this.graphics.clear();
			this.graphics.beginFill(0x99ccff, 0.1);
			this.graphics.lineStyle(1, 0x000000, 0.4);
			this.graphics.drawRect(targetPoint.x, targetPoint.y, recWidth, recHeight)
			this.graphics.endFill();
		}
		
		private function mouseUpHandler(evt:MouseEvent):void {
			evt.currentTarget.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			rec = this.getBounds(this);
			this.graphics.clear();
		}
		
		public function draw(canvas:Sprite, rect:Rectangle, _speed:Number = 0, _steps:Number = 0):void {
			paint(canvas, rect);
			
			if (_speed == 0) {
				_speed = 32;
			}
			if (_speed != 0 && _speed < 10)
				_speed = 10;
			
			if (_steps == 0)
				_steps = 1;
			_steps = ((_steps % patternLength) + patternLength) % patternLength;
			
			clearInterval(updateID);
			if (_speed != 0) {
				updateID = setInterval(update, _speed, _steps);
			}
			
			if (getTimer() - lastUpdate > _speed)
				update(_steps);
		}
		
		private function paint(canvas:Sprite, r:Rectangle):void {
			var rect:Rectangle = new Rectangle(r.width < 0 ? r.x + r.width : r.x, r.height < 0 ? r.y + r.height : r.y, Math.abs(r.width), Math.abs(r.height));
			
			canvas.graphics.lineStyle();
			canvas.graphics.moveTo(rect.left, rect.top);
			canvas.graphics.beginBitmapFill(patternMap, new Matrix(1, 0, 0, 1, rect.left % patternLength, 0));
			canvas.graphics.lineTo(rect.left + rect.width, rect.top);
			canvas.graphics.lineTo(rect.left + rect.width, rect.top + 1);
			canvas.graphics.lineTo(rect.left, rect.top + 1);
			canvas.graphics.lineTo(rect.left, rect.top);
			canvas.graphics.endFill();
			
			canvas.graphics.moveTo(rect.left + rect.width, rect.top + 1);
			canvas.graphics.beginBitmapFill(patternMap, new Matrix(0, 1, 1, 0, 0, 1 + rect.top % patternLength + patternLength - rect.width % patternLength));
			canvas.graphics.lineTo(rect.left + rect.width, rect.top + rect.height);
			canvas.graphics.lineTo(rect.left + rect.width - 1, rect.top + rect.height);
			canvas.graphics.lineTo(rect.left + rect.width - 1, rect.top + 1);
			canvas.graphics.lineTo(rect.left + rect.width, rect.top + 1);
			canvas.graphics.endFill();
			
			canvas.graphics.moveTo(rect.left, rect.top + rect.height - 1);
			canvas.graphics.beginBitmapFill(patternMap, new Matrix(-1, 0, 0, 1, rect.left + rect.width - 1 - (patternLength - (rect.width + rect.height - 1) % patternLength), 0));
			canvas.graphics.lineTo(rect.left + rect.width - 1, rect.top + rect.height - 1);
			canvas.graphics.lineTo(rect.left + rect.width - 1, rect.top + rect.height);
			canvas.graphics.lineTo(rect.left, rect.top + rect.height);
			canvas.graphics.lineTo(rect.left, rect.top + rect.height - 1);
			canvas.graphics.endFill();
			
			canvas.graphics.moveTo(rect.left, rect.top + 1);
			canvas.graphics.beginBitmapFill(patternMap, new Matrix(0, -1, 1, 0, 0, 1 + rect.top % patternLength));
			canvas.graphics.lineTo(rect.left + 1, rect.top + 1);
			canvas.graphics.lineTo(rect.left + 1, rect.top + rect.height - 1);
			canvas.graphics.lineTo(rect.left, rect.top + rect.height - 1);
			canvas.graphics.lineTo(rect.left, rect.top + 1);
			canvas.graphics.endFill();
		}
		
		private var patternMap:BitmapData;
		private var updateID:Number;
		private var lastUpdate:Number;
		
		private function update(steps:Number):void {
			do {
				var p:Number = patternMap.getPixel32(patternMap.width - 1, 0);
				patternMap.copyPixels(patternMap, copyRect, copyPoint);
				patternMap.setPixel32(0, 0, p);
			} while (--steps > 0);
			
			lastUpdate = getTimer();
		}
	}
}

import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;

var pointX_tf:TextField;
var pointY_tf:TextField;
var selectW_tf:TextField;
var selectH_tf:TextField;

//var tf_fmt:TextFormat = new TextFormat("Verdana", 12, 0xFFD030, null, null, null, null, null, "left");
var tf_fmt:TextFormat = new TextFormat("Meiryo", 12, 0xFFD030, null, null, null, null, null, "left");

class selectInfo extends Sprite {
	
	public function selectInfo():void {
		init();
	}
	
	private function init():void {
		this.graphics.beginFill(0x000000, 0.7);
		this.graphics.lineStyle(1, 0x000000, 1);
		this.graphics.drawRect(0, 0, 60, 90);
		
		pointX_tf = new TextField();
		pointY_tf = new TextField();
		selectW_tf = new TextField();
		selectH_tf = new TextField();
		
		pointX_tf.defaultTextFormat = tf_fmt;
		pointY_tf.defaultTextFormat = tf_fmt;
		selectW_tf.defaultTextFormat = tf_fmt;
		selectH_tf.defaultTextFormat = tf_fmt;
		
		pointX_tf.selectable = false;
		pointY_tf.selectable = false;
		selectW_tf.selectable = false;
		selectH_tf.selectable = false;
		
		addChild(pointX_tf);
		addChild(pointY_tf);
		addChild(selectW_tf);
		addChild(selectH_tf);
		
		pointX_tf.x = 6;
		pointX_tf.y = 6;
		
		pointY_tf.x = 6;
		pointY_tf.y = pointX_tf.y + 20;
		
		selectW_tf.x = 6;
		selectW_tf.y = pointY_tf.y + 20;
		
		selectH_tf.x = 6;
		selectH_tf.y = selectW_tf.y + 20;
	}
	
	public function upDatePoint(pt:Point):void {
		pointX_tf.text = "X : " + pt.x;
		pointY_tf.text = "Y : " + pt.y;
	}
	
	public function upDateRect(sw:int, sh:int):void {
		selectW_tf.text = "W : " + sw;
		selectH_tf.text = "H : " + sh;
	}

}
