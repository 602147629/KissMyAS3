package com.soar.air.utils {
	import flash.net.InterfaceAddress;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/22 下午 04:51
	 * @version	：1.0.12
	 */
	
	public class Network {
		public function Network():void {
		}
		
		//這裡是直接獲取本機第一個網卡的ip地址代碼:
		public function getIP():void {
			var netinfo:NetworkInfo = NetworkInfo.networkInfo;
			var interfaces:Vector.<flash.net.NetworkInterface> = netinfo.findInterfaces();
			
			if (interfaces != null) {
				trace("MAC地址：" + interfaces[0].hardwareAddress)
				trace("本機IP地址:" + interfaces[0].addresses[0].address)
			}
			
			//顯示出本機所有的網絡物理信息:
			for each (var interfaceObj:NetworkInterface in interfaces) {
				trace("\nname: " + interfaceObj.name);
				trace("display name: " + interfaceObj.displayName);
				trace("mtu: " + interfaceObj.mtu);
				trace("active?: " + interfaceObj.active);
				trace("parent interface: " + interfaceObj.parent);
				trace("hardware address: " + interfaceObj.hardwareAddress);
				
				if (interfaceObj.subInterfaces != null) {
					trace("# subinterfaces: " + interfaceObj.subInterfaces.length);
				}
				
				trace("# addresses: " + interfaceObj.addresses.length);
				for each (var address:InterfaceAddress in interfaceObj.addresses) {
					trace("  type: " + address.ipVersion);
					trace("  address: " + address.address);
					trace("  broadcast: " + address.broadcast);
					trace("  prefix length: " + address.prefixLength);
				}
			}
		}
	}
}