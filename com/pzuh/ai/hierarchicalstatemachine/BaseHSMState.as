package com.pzuh.ai.hierarchicalstatemachine 
{

	public class BaseHSMState
	{
		protected var parentState:BaseHSMState;
		protected var childStateArray:Array;
		protected var initState:BaseHSMState;
		
		protected var level:int;
		
		protected var name:String;
		
		protected var myEntity:Object;
		
		protected var transitionArray:Array;
		
		protected var action:Object;
		
		public function BaseHSMState(entity:Object, name:String) 
		{
			childStateArray = new Array();
			
			myEntity = entity;
			
			transitionArray = new Array();
			
			action = new Object();
			
			this.name = name;
		}
		
		public function addChildState(state:BaseHSMState):void
		{
			if (childStateArray.indexOf(state) == -1)
			{
				if (initState == null)
				{
					initState = state;
				}
				
				childStateArray.push(state);
				state.parentState = this;
				state.level = this.level + 1;
			}
		}
		
		public function addTransition(targetState:String, trigger:Function):void
		{
			var transitionObject:Object = new Object();
			transitionObject.targetState = targetState;
			transitionObject.trigger = trigger;			
			
			if (transitionArray.indexOf(transitionObject) == -1)
			{
				transitionArray.push(transitionObject);
			}
		}
		
		public function addAction(update:Function, enter:Function = null, exit:Function = null):void
		{
			action.update = update;
			action.enter = enter;
			action.exit = exit;
		}
		
		private function removeChildState():void
		{
			if (childStateArray.length > 0) 
			{
				for (var i:int = childStateArray.length - 1; i >= 0; i--)
				{
					childStateArray.splice(i, 1);
				}
				
				childStateArray = null;
			}
		}
		
		private function removeTransition():void
		{
			if (transitionArray.length > 0)
			{
				for (var i:int = transitionArray.length - 1; i >= 0; i--)
				{
					transitionArray.splice(i, 1);
				}
				
				transitionArray = null;
			}
		}
		
		public function removeSelf():void
		{
			removeChildState();
			
			removeTransition();
			
			action = null;
			
			parentState = null;
			initState = null;
			
			myEntity = null;
		}
		
		public function getParent():BaseHSMState
		{
			return parentState;
		}
		
		public function getInitState():BaseHSMState
		{
			return initState;
		}
		
		public function getLevel():int
		{
			return level;
		}
		
		public function getName():String
		{
			return name;
		}
		
		//make sure this three method are overriden by the concrete state
		public function enter():void
		{
			if (action.enter!=null) 
			{
				action.enter.apply();
			}
		}
		
		public function update():void
		{
			/* This block is used if you define the transition outside the state class.
			   Make sure you call super.update() in the overriden method if you use it.
			*/
			if (transitionArray.length > 0) 
			{
				for (var i:int = 0; i < transitionArray.length; i++)
				{
					if (transitionArray[i].trigger.apply() == true)
					{
						myEntity.changeState(transitionArray[i].targetState);
						
						return;
					}
				}
			}
			
			if (action.update != null)
			{
				action.update.apply();
			}
		}
		
		public function exit():void
		{
			if (action.exit !=null) 
			{
				action.exit.apply();
			}
		}
	}
}