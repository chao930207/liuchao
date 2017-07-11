package test_002_thread;

/*=============================================================================
#     FileName: IdcardValidator.java
#         Desc: 
#       Author: LChao
#        Email: chao930207@gmail.com
#     HomePage: 
#      Version: 0.0.1
#   LastChange: 2016-07-12 16:22:30
#      History:
=============================================================================*/
import static java.lang.System.in;
import static java.lang.System.out;
import static java.util.regex.Pattern.matches;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

/**
 * --15位身份证号码
 * --第7、8位为出生年份(两位数)，第9、10位为出生月份，第11、12位代表出生日期，第15位代表性别，奇数为男，偶数为女。
 *
 * --18位身份证号码
 * --第7、8、9、10位为出生年份(四位数)，第11、第12位为出生月份，第13、14位代表出生日期，第17位代表性别，奇数为男，偶数为女。
 */
public class IdcardValidator {

    /**
     * 省，直辖市代码表 ：{
     * 11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
     * 21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",
     * 34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",
     * 43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",
     * 52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",
     * 64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外" }
     */

    // 每位加权因子
    private static int power[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };

    /**
     * 验证身份证是否合法
     * 
     * @param idcard
     * @return boolean
     */
    @SuppressWarnings("static-access")
    public boolean isValidatedAllIdcard(String idcard) {
        return this.isValidate18Idcard(idcard);
    }

    /**
     * @param idno
     * @return String
     */
    public static int getUserSex(String idno) {

        String sex="1";

        if(idno != null){
            if(idno.length()>15){
                sex = idno.substring(16, 17);
            }
        }

        return Integer.parseInt(sex) % 2 == 0 ? 0 : 1;
    }

    /**
     * <p>判断18位身份证的合法性</p>
     * 根据〖中华人民共和国国家标准GB11643-1999〗中有关公民身份号码的规定，公民身份号码是特征组合码，由十七位数字本体码和一位数字校验码组成。
     * 排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
     * <p>顺序码: 表示在同一地址码所标识的区域范围内，对同年、同月、同 日出生的人编定的顺序号，顺序码的奇数分配给男性，偶数分配 给女性。</p>
     * <p>1.前1、2位数字表示：所在省份的代码；</p>
     * <p>2.第3、4位数字表示：所在城市的代码；</p>
     * <p>3.第5、6位数字表示：所在区县的代码；</p>
     * <p>4.第7~14位数字表示：出生年、月、日；</p>
     * <p>5.第15、16位数字表示：所在地的派出所的代码；</p>
     * <p>6.第17位数字表示性别：奇数表示男性，偶数表示女性；</p>
     * <p>7.第18位数字是校检码：也有的说是个人信息码，一般是随计算机的随机产生，用来检验身份证的正确性。校检码可以是0~9的数字，有时也用X表示。</p>
     * <p>第十八位数字(校验码)的计算方法为：</p>
     * <p>1.将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2；</p>
     * <p>2.将这17位数字和系数相乘的结果相加；</p>
     * <p>3.用加出来和除以11，看余数是多少；</p>
     * <p>4.余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2；</p>
     * <p>5.通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。如果余数是10，身份证的最后一位号码就是2。</p>
     * 
     * @param idcard
     * @return boolean
     */
    private static boolean isValidate18Idcard(String idcard) {

        // 非18位为假
        if (idcard.length() != 18) {
            return false;
        }

        // 获取前17位
        String idcard17 = idcard.substring(0, 17);
        // 获取第18位
        String idcard18Code = idcard.substring(17, 18);
        char c[] = null;
        String checkCode = "";

        // 是否都为数字
        if (isDigital(idcard17)) {
            c = idcard17.toCharArray();
        } else {
            return false;
        }
        
        // 判断日期是否正确
        if (checkDate(idcard)) {
        } else {
        	return false;
        }

        if (null != c) {
            int bit[] = new int[idcard17.length()];
            int sum17 = 0;

            bit = converCharToInt(c);
            sum17 = getPowerSum(bit);
            // 将和值与11取模得到余数进行校验码判断
            checkCode = getCheckCodeBySum(sum17);

            if (null == checkCode) {
                return false;
            }

            // 将身份证的第18位与算出来的校码进行匹配，不相等就为假
            if (!idcard18Code.equalsIgnoreCase(checkCode)) {
                return false;
            }
        }

        return true;
    }

    /**
     * 18位身份证号码的基本数字和位数验校
     * 
     * @param idcard
     * @return boolean
     */
    private static boolean is18Idcard(String idcard) {
        return matches("^[1-9]\\d{5}[1-9]\\d{3}((0[1-9])|(1[0-2]))((0[1-9])|([1|2]\\d)|3[0-1])\\d{3}([\\d|X]{1})$", idcard);
    }

    /**
     * 数字验证
     * 
     * @param str
     * @return boolean
     */
    private static boolean isDigital(String str) {
        return str == null || "".equals(str) ? false : str.matches("^[0-9]*$");
    }

    /**
     * 将身份证的每位和对应位的加权因子相乘之后，再得到和值
     * 
     * @param bit
     * @return int
     */
    private static int getPowerSum(int[] bit) {

        int sum = 0;

        if (power.length != bit.length) {
            return sum;
        }

        for (int i = 0; i < bit.length; i++) {
            sum += bit[i] * power[i];
        }

        return sum;
    }

    /**
     * 将和值与11取模得到余数进行校验码判断
     * 
     * @param sum17
     * @return String
     */
    private static String getCheckCodeBySum(int sum17) {

        String checkCode = null;

        switch (sum17 % 11) {
            case 10:
                checkCode = "2";
                break;
            case 9:
                checkCode = "3";
                break;
            case 8:
                checkCode = "4";
                break;
            case 7:
                checkCode = "5";
                break;
            case 6:
                checkCode = "6";
                break;
            case 5:
                checkCode = "7";
                break;
            case 4:
                checkCode = "8";
                break;
            case 3:
                checkCode = "9";
                break;
            case 2:
                checkCode = "x";
                break;
            case 1:
                checkCode = "0";
                break;
            case 0:
                checkCode = "1";
                break;
        }

        return checkCode;
    }

    /**
     * 将字符数组转为整型数组
     * 
     * @param c
     * @return int[]
     * @throws NumberFormatException
     */
    private static int[] converCharToInt(char[] c) throws NumberFormatException {

        int[] a = new int[c.length];
        int k = 0;

        for (char temp : c) {
            a[k++] = Integer.parseInt(String.valueOf(temp));
        }

        return a;
    }
    
    /**
     * 判断日期是否正确
     * @param idcard
     * @return boolean
     */
    private static boolean checkDate(String idcard) {
    	
    	String idcardDate = idcard.substring(6, 14);
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	
    	// 设置lenient为false. 否则SimpleDateFormat会比较宽松地验证日期，比如2007/02/29会被接受，并转换成2007/03/01
    	sdf.setLenient(false);
    	
    	try {
			sdf.parse(idcardDate);
			return true;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			return false;
		}
    }

    public static void main(String[] args) {

        /*Scanner _input = new Scanner(in);
        out.println("input your idcard, please");
        String idcard = _input.next();
        
        if (is18Idcard(idcard)) {
        	out.println("the format of ID card is true");
        } else {
        	out.println("the format of ID card is false");
        }
        
        if (isValidate18Idcard(idcard)) {
        	out.println("the validity of ID card is true");
        	out.println("sex : " + (getUserSex(idcard) == 1 ? "man" : "woman"));
        } else {
        	out.println("the validity of ID card is false");
        }*/
        
    	String str = "123b1.23";
    	Object o = null;
    	int i = 3;
    	int t = 5;
    	
    	try {
    		String s = o.toString();
    		BigDecimal b = new BigDecimal(str);
    		out.println(b);
    	} catch (Exception e) {
    		out.println(e);
    		out.println("e message : " + e.getMessage());
    		if (e instanceof NullPointerException) {
    			out.println("this is null");
    		}
    		if (e instanceof NumberFormatException) {
    			out.println("An exception occurs when \"" + o + "\" is forced to convert");
    		}
    	}
    	
    	out.println("i : " + (i << 2));
    	
    	out.println(i);
    	
    	out.println("i : " + (i ^ t));
    	out.println("i : " + (i | t));
    	out.println("i : " + (i & t));
    	out.println("i : " + (~ t));
    	
    }
}