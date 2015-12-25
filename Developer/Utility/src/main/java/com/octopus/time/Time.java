package com.octopus.time;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author yorg
 */
public class Time {
   private String time;
   int year;
   int month;
   int day;
   int hour;
   int minute;
   int second;
   int milliSecond;
   
   public Time(String time) {
      this.time = time;
      
      this.year = Integer.parseInt(time.substring(0, 4));
      this.month = Integer.parseInt(time.substring(4, 6));
      this.day = Integer.parseInt(time.substring(6, 8));
      this.hour = Integer.parseInt(time.substring(8, 10));
      this.minute = Integer.parseInt(time.substring(10, 12));
      this.second = Integer.parseInt(time.substring(12, 14));
      this.milliSecond = Integer.parseInt(time.substring(14, 17));
      
   }
   
   public Time() {
      this(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
   }
   
   
   public String getDay(){
      int temp = (this.year * 100 + this.month) * 100 + this.day;
      return String.valueOf(temp);
   }
   
   public String toString() {
      return this.time;
   }
   
}
