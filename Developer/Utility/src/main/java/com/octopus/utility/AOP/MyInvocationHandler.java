/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.octopus.utility.AOP;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

/**
 *
 * @author yorg
 */
public class MyInvocationHandler implements InvocationHandler {
   private Object target = null;
   
   public MyInvocationHandler(Object t) {
      this.target = t;
   }
   
   public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
      System.out.println("this is before");
      System.out.println(method.getName());
      Object obj = method.invoke(this.target, args);
      System.out.println("this is after");
      return obj;
   }
}
