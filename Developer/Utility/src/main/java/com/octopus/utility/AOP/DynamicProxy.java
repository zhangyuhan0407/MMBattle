/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.octopus.utility.AOP;

import java.lang.reflect.Proxy;

/**
 *
 * @author yorg
 */
public class DynamicProxy<T> {
   public static <T> T newInstance(Object obj) {
      return (T)Proxy.newProxyInstance(obj.getClass().getClassLoader(), obj.getClass().getInterfaces(), new MyInvocationHandler(obj));
   }
}
