*============================================================*
**       		 父母对孩子成绩的感知
**Goal		:    父母对孩子的成绩的理解
**Data		:    CEPS
**Author	:  	 ZhangYi zhangyiceee@163.com 15592606739
**Created	:  	 20201011
**Last Modified: 2020
*============================================================*

/*
  ___  ____  ____  ____  ____ 
 /__    /   ____/   /   ____/
___/   /   /___/   /   /___/ 
*/

	capture	clear all
	capture log close
	set	more off
	set scrollbufsize 2048000
	capture log close 
	

*具体文章信息DOI：10.1016/j.econlet.2015.10.025
	cd "/Users/zhangyi/Documents/数据集/CEPS"
	global cleandir "/Users/zhangyi/Desktop/CEPS/behavior/clean"
	global outdir "/Users/zhangyi/Desktop/CEPS/behavior/output"
	global working "/Users/zhangyi/Desktop/CEPS/behavior/working"



*调用学生数据
	use "2014baseline/CEPS基线调查学生数据.dta",clear 

*年龄
	gen  age =2014-a02a
	label var age "年龄"
	tab age,m
*年龄的计算还需要再斟酌
*性别
	tab a01,m
	codebook a01
	gen female =.
	replace female =1 if a01==2
	replace female =0 if a01==1
	label var female "女性"
*户口
	gen rural=.
	codebook a06
	replace rural =1 if a06==1
	replace rural =0 if a06==2 | a06==3 |a06==4
	label var rural "农村户口=1"
*民族
	codebook a03 //有缺失项
	gen minority=0
	replace minority=1 if a03>=2 & a03<=5
	tab minority
	replace minority=. if a03==.
	lab var minority "少数民族"
*父母受教育程度
	*父亲
	codebook stfedu
*小学及以下下
	gen fa_edu_p=0
	replace fa_edu_p =1 if stfedu ==1 | stfedu ==2
	tab fa_edu_p,m
	label var fa_edu_p "小学及以下"
*初中
	gen fa_edu_m=0
	replace fa_edu_m =1 if stfedu ==3
	tab fa_edu_m,m
	label var fa_edu_m "初中"
*高中、技术
	gen fa_edu_h=0
	replace fa_edu_h =1 if stfedu ==4 |  stfedu ==5 | stfedu ==6
	tab fa_edu_h,m
	label var fa_edu_h "高中"
*大学及以上
	gen fa_edu_u=0
	replace fa_edu_u =1 if stfedu ==8 |  stfedu ==9 
	tab fa_edu_u,m
	label var fa_edu_u "大学及以上"
	
	foreach x of varlist  fa_edu_p-fa_edu_u {
		replace `x'=. if stfedu==.
	}
*父亲受教育年限
	gen fa_eduyear=.
	replace fa_eduyear=0 if stfedu==1
	replace fa_eduyear=6 if stfedu==2
	replace fa_eduyear=9 if stfedu==3
	replace fa_eduyear=11 if stfedu==4 
	replace fa_eduyear=11 if stfedu==5 
	replace fa_eduyear=12 if stfedu==6
	replace fa_eduyear=15 if stfedu==7
	replace fa_eduyear=16 if stfedu==8
	replace fa_eduyear=19 if stfedu==9
	label var fa_eduyear "父亲受教育年限"
*父受教育在高中及以上
	gen high_f =.
	replace high_f =0 if stfedu >= 0 & stfedu<6
	replace high_f =1 if stfedu >= 6 & stfedu<=9
	label var high_f "父亲受教育程度在高中及以上"

*母亲
*母亲受教育水平
*小学及以下下
	gen me_edu_p=0
	replace me_edu_p =1 if stmedu ==1 | stmedu ==2
	tab me_edu_p,m
	label var me_edu_p "小学及以下"
*初中
	gen me_edu_m=0
	replace me_edu_m =1 if stmedu ==3
	tab me_edu_m,m
	label var me_edu_m "初中"
*高中、技术
	gen me_edu_h=0
	replace me_edu_h =1 if stmedu ==4 |  stmedu ==5 | stmedu ==6
	tab me_edu_h,m
	label var me_edu_h "高中"
*大学及以上
	gen me_edu_u=0
	replace me_edu_u =1 if stmedu ==8 |  stmedu ==9 
	tab me_edu_u,m

	label var me_edu_u "大学及以上"

*母亲受教育年限
	gen mo_eduyear=.
	replace mo_eduyear=0 if stmedu==1
	replace mo_eduyear=6 if stmedu==2
	replace mo_eduyear=9 if stmedu==3
	replace mo_eduyear=11 if stmedu==4 
	replace mo_eduyear=11 if stmedu==5 
	replace mo_eduyear=12 if stmedu==6
	replace mo_eduyear=15 if stmedu==7
	replace mo_eduyear=16 if stmedu==8
	replace mo_eduyear=19 if stmedu==9
	label var mo_eduyear "母亲受教育年限"
*母亲受教育程度在高中及以上
	gen high_m =.
	replace high_m =0 if stmedu >= 0 & stmedu<6
	replace high_m =1 if stmedu >= 6 & stmedu<=9
	label var high_m "母亲受教育程度在高中及以上"

foreach x of varlist  me_edu_p-me_edu_u {
		replace `x'=. if stmedu==.
	}

 *兄弟姐妹个数
	tab1 b0201  b0202 b0203 b0204,m
 
	foreach x of varlist b0201 b0202 b0203 b0204 {
	replace `x' =0 if `x'==.
	}
 
	gen siblings =b0201+ b0202+ b0203+ b0204
	replace siblings =. if b0201==. & b0202==. & b0203==. & b0204==.
	tab siblings,m

*自己对自己学习的感知
	tab c12,m
	codebook c12
	clonevar selfbelief=c12
	label var  selfbelief  "自我感知的排名"

	merge 1:1 ids using "2014baseline/CEPS基线调查家长数据.dta"


*父母的感知
	codebook bc10

	clonevar parentbelief=bc10
	label var  parentbelief  "父母感知的排名"

	clonevar  selfbelief_1=selfbelief


	twoway  (lfit parentbelief selfbelief )(lfit selfbelief_1 selfbelief ), legend(label(1 父母感知) label(2 完全知晓的理想情况))

gen fudaoban=0
replace fudaoban=1 if ba02==1

	twoway  (qfit fudaoban parentbelief  )(qfit fudaoban selfbelief ), legend(label(1 父母感知的决策) label(2 真实情况))
	






	