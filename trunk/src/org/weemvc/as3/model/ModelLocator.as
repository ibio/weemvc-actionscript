/**
 * WeeMVC - Copyright(c) 2008-2009
 * 单例模式的数据集合
 * @author	weemve.org
 * 2009-1-8 22:59
 */
package org.weemvc.as3.model {
	import org.weemvc.as3.core.WeemvcLocator;
	import org.weemvc.as3.WeemvcError;
	import org.weemvc.as3.PaperLogger;
	
	public class ModelLocator extends WeemvcLocator implements IModelLocator {
		static private var m_instance:IModelLocator = null;
		
		public function ModelLocator() {
			if (m_instance) {
				throw new WeemvcError(WeemvcError.SINGLETON_MODEL_MSG, ModelLocator);
			}else {
				m_instance = this;
			}
		}
		
		static public function getInstance():IModelLocator {
			if (!m_instance) {
				m_instance = new ModelLocator();
			}
			return m_instance;
		}
		
		/**
		 * 取回模型
		 * @param	modelName<Class>：	模型类
		 * @return<*>：					当前模型实例
		 */
		public function getModel(modelName:Class):* {
			if (!hasExists(modelName)) {
				PaperLogger.getInstance().log(WeemvcError.MODEL_NOT_FOUND, ModelLocator, modelName);
			}
			return retrieve(modelName);
		}
		
		/**
		 * 添加模型
		 * @param	modelName<Class>：	模型类
		 * @param	data<Object>：		当前模型构造函数的参数
		 */
		public function addModel(modelName:Class, data:Object = null):void {
			if (!hasExists(modelName)) {
				if (data) {
					add(modelName, new modelName(data));
				}else {
					add(modelName, new modelName());
				}
			}else {
				PaperLogger.getInstance().log(WeemvcError.ADD_MODEL_MSG, ModelLocator, modelName);
			}
		}
		
		/**
		 * 移除模型
		 * @param	modelName<Class>：	模型类
		 */
		public function removeModel(modelName:Class):void {
			if (hasExists(modelName)) {
				remove(modelName);
			}else {
				PaperLogger.getInstance().log(WeemvcError.REMOVE_MODEL_MSG, ModelLocator, modelName);
			}
		}
		
		/**
		 * 判断此模型是否已经存在
		 * @param	modelName<Class>：	模型类
		 * @return<Boolean>：			是否存在
		 */
		public function hasModel(modelName:Class):Boolean {
			return hasExists(modelName);
		}
	}
}