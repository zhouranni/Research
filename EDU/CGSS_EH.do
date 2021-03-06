*============================================================*
**       		CGSS 
**Goal		:  The impact of education on people's health-高校扩招的证据
**Data		:    CFPS2010-CFPS2018
**Author	:  	 ZhangYi zhangyiceee@163.com 15592606739
**Created	:  	 20201009
**Last Modified: 20200
*============================================================*
	capture	clear
	capture log close
	set	more off
	set scrollbufsize 2048000
	capture log close 
	


	cd "/Users/zhangyi/Documents/data/CGSS"
	global outdir "/Users/zhangyi/Desktop/EDU_HEALTH/output"
	global workingdir "/Users/zhangyi/Desktop/EDU_HEALTH/working"


	use "2010/cgss2010_14.dta",clear

	*受教育程度
	/*只保留高中及以上的受教育程度*/
*受教育年限赋值方式为： “ 没受过任何教育” ＝０ ，“ 小学” ＝６ ，“ 初中” ＝９ 年， “ 中专／技 校” ＝１１ 年， “ 职业高中” ＝１１ 年， “ 高中” ＝１２ 年， “ 大学专科” ＝１５ 年， “ 大学本科” ＝１６ 年， “ 研究生及以上” ＝１９ 年。
	tab1 a7a a7b a7c,m
	tab1 a7a ,m
	label list a7alab
	gen edu_year=.
	replace edu_year=12 if a7a==5
	replace edu_year=12 if a7a==6
	replace edu_year=11 if a7a==7
	replace edu_year=11 if a7a==8
	replace edu_year=15 if a7a==9
	replace edu_year=15 if a7a==10
	replace edu_year=16 if a7a==11
	replace edu_year=16 if a7a==12
	replace edu_year=19 if a7a==13
	tab edu_year,m

*出生年月
	tab1 a3a a3b a3c,m
	label list a3blab
	replace a3a=. if a3a <0
	replace a3b=. if a3b <0
	replace a3c=1 if a3c <0
	tostring a3a a3b a3c ,replace force

	replace a3b="jan" if a3b=="1"
	replace a3b="feb" if a3b=="2"
	replace a3b="mar" if a3b=="3"
	replace a3b="apr" if a3b=="4"
	replace a3b="may" if a3b=="5"
	replace a3b="jun" if a3b=="6"
	replace a3b="jul" if a3b=="7"
	replace a3b="aug" if a3b=="8"
	replace a3b="sep" if a3b=="9"
	replace a3b="oct" if a3b=="10"
	replace a3b="nov" if a3b=="11"
	replace a3b="dec" if a3b=="12"


	replace a3c="01" if a3c=="1"
	replace a3c="02" if a3c=="2"
	replace a3c="03" if a3c=="3"
	replace a3c="04" if a3c=="4"
	replace a3c="05" if a3c=="5"
	replace a3c="06" if a3c=="6"
	replace a3c="07" if a3c=="7"
	replace a3c="08" if a3c=="8"
	replace a3c="09" if a3c=="9"

	gen birthday =a3a+a3b+a3c if a3a!="." & a3b!="." &a3c!="."
	bro birthday a3*
	gen birthday_1 =date(birthday,"YMD")
	format %td birthday_1
	bro birth* a3a a3b
	rename birthday_1 birth_day
	label var birth_day "出生日期"
*户口
	codebook a18
	gen urban=.
	replace urban=1 if a18==2
	replace urban=0 if a18==1
	label var urban "城镇户口=1"
*民族：汉族=1 
	codebook a4
	gen hanzu=0
	replace hanzu=1 if a4==1
	label var hanzu "汉族=1"

*婚姻:已婚=1
	codebook a69
	gen marry =0
	replace marry=1 if a69==3
	label var marry "已婚=1"
*性别
	codebook a2
	gen male=0
	replace male =1 if a2==1
	label var male "男性=1"


*健康状况
	tab a15,m
	label list a15lab
	clonevar health=a15
	replace health=. if health==-3


*父母edu a89b a90b
	label list lab4
	gen fa_edu_h=.
	replace fa_edu_h =1 if a89b >=6
	replace fa_edu_h =0 if a89b <6
	label var fa_edu_h "父亲受教育程度在高中及以上"

	gen mo_edu_h=.
	replace mo_edu_h =1 if a90b >=6
	replace mo_edu_h =0 if a90b <6
	label var mo_edu_h "母亲受教育程度在高中及以上"

,
	save "$workingdir/CGSS2010.dta",replace 

	use "2012/cgss2012_14.dta",clear

		*受教育程度
	/*只保留高中及以上的受教育程度*/
*受教育年限赋值方式为： “ 没受过任何教育” ＝０ ，“ 小学” ＝６ ，“ 初中” ＝９ 年， “ 中专／技 校” ＝１１ 年， “ 职业高中” ＝１１ 年， “ 高中” ＝１２ 年， “ 大学专科” ＝１５ 年， “ 大学本科” ＝１６ 年， “ 研究生及以上” ＝１９ 年。
	tab1 a7a a7b a7c,m
	tab1 a7a ,m
	label list lab5
	gen edu_year=.
	replace edu_year=12 if a7a==5
	replace edu_year=12 if a7a==6
	replace edu_year=11 if a7a==7
	replace edu_year=11 if a7a==8
	replace edu_year=15 if a7a==9
	replace edu_year=15 if a7a==10
	replace edu_year=16 if a7a==11
	replace edu_year=16 if a7a==12
	replace edu_year=19 if a7a==13
	tab edu_year,m

*出生年月
	tab1 a3a a3b a3c,m
	label list lab1
	replace a3a=. if a3a <0
	replace a3b=. if a3b <0
	replace a3c=1 if a3c <0
	tostring a3a a3b a3c ,replace force

	replace a3b="jan" if a3b=="1"
	replace a3b="feb" if a3b=="2"
	replace a3b="mar" if a3b=="3"
	replace a3b="apr" if a3b=="4"
	replace a3b="may" if a3b=="5"
	replace a3b="jun" if a3b=="6"
	replace a3b="jul" if a3b=="7"
	replace a3b="aug" if a3b=="8"
	replace a3b="sep" if a3b=="9"
	replace a3b="oct" if a3b=="10"
	replace a3b="nov" if a3b=="11"
	replace a3b="dec" if a3b=="12"


	replace a3c="01" if a3c=="1"
	replace a3c="02" if a3c=="2"
	replace a3c="03" if a3c=="3"
	replace a3c="04" if a3c=="4"
	replace a3c="05" if a3c=="5"
	replace a3c="06" if a3c=="6"
	replace a3c="07" if a3c=="7"
	replace a3c="08" if a3c=="8"
	replace a3c="09" if a3c=="9"

	gen birthday =a3a+a3b+a3c if a3a!="." & a3b!="." &a3c!="."
	bro birthday a3*
	gen birthday_1 =date(birthday,"YMD")
	format %td birthday_1
	bro birth* a3a a3b
	rename birthday_1 birth_day
	label var birth_day "出生日期"
*户口
	codebook a18
	gen urban=0
	replace urban=1 if a18==2
	label var urban "城镇户口=1"
*民族：汉族=1 
	codebook a4
	gen hanzu=0
	replace hanzu=1 if a4==1
	label var hanzu "汉族=1"

*婚姻:已婚=1
	codebook a69
	gen marry =0
	replace marry=1 if a69==3 |a69==4
	label var marry "已婚=1"
*性别
	codebook a2
	gen male=0
	replace male =1 if a2==1
	label var male "男性=1"

*健康状况
	tab a15,m
	label list a15lab
	clonevar health=a15
	replace health=. if health<0


*父母edu a89b a90b
	label list lab4
	gen fa_edu_h=.
	replace fa_edu_h =1 if a89b >=6
	replace fa_edu_h =0 if a89b <6
	label var fa_edu_h "父亲受教育程度在高中及以上"

	gen mo_edu_h=.
	replace mo_edu_h =1 if a90b >=6
	replace mo_edu_h =0 if a90b <6
	label var mo_edu_h "母亲受教育程度在高中及以上"
	
	save "$workingdir/CGSS2012.dta",replace 

	
	use "2013/cgss2013_14.dta",clear

		*受教育程度
	/*只保留高中及以上的受教育程度*/
*受教育年限赋值方式为： “ 没受过任何教育” ＝０ ，“ 小学” ＝６ ，“ 初中” ＝９ 年， “ 中专／技 校” ＝１１ 年， “ 职业高中” ＝１１ 年， “ 高中” ＝１２ 年， “ 大学专科” ＝１５ 年， “ 大学本科” ＝１６ 年， “ 研究生及以上” ＝１９ 年。
	tab1 a7a a7b a7c,m
	tab1 a7a ,m
	label list lab5
	gen edu_year=.
	replace edu_year=12 if a7a==5
	replace edu_year=12 if a7a==6
	replace edu_year=11 if a7a==7
	replace edu_year=11 if a7a==8
	replace edu_year=15 if a7a==9
	replace edu_year=15 if a7a==10
	replace edu_year=16 if a7a==11
	replace edu_year=16 if a7a==12
	replace edu_year=19 if a7a==13
	tab edu_year,m

*出生年月
	tab1 a3a a3b a3c,m
	label list lab1
	replace a3a=. if a3a <0
	replace a3b=. if a3b <0
	replace a3c=1 if a3c <0
	tostring a3a a3b a3c ,replace force

	replace a3b="jan" if a3b=="1"
	replace a3b="feb" if a3b=="2"
	replace a3b="mar" if a3b=="3"
	replace a3b="apr" if a3b=="4"
	replace a3b="may" if a3b=="5"
	replace a3b="jun" if a3b=="6"
	replace a3b="jul" if a3b=="7"
	replace a3b="aug" if a3b=="8"
	replace a3b="sep" if a3b=="9"
	replace a3b="oct" if a3b=="10"
	replace a3b="nov" if a3b=="11"
	replace a3b="dec" if a3b=="12"


	replace a3c="01" if a3c=="1"
	replace a3c="02" if a3c=="2"
	replace a3c="03" if a3c=="3"
	replace a3c="04" if a3c=="4"
	replace a3c="05" if a3c=="5"
	replace a3c="06" if a3c=="6"
	replace a3c="07" if a3c=="7"
	replace a3c="08" if a3c=="8"
	replace a3c="09" if a3c=="9"

	gen birthday =a3a+a3b+a3c if a3a!="." & a3b!="." &a3c!="."
	bro birthday a3*
	gen birthday_1 =date(birthday,"YMD")
	format %td birthday_1
	bro birth* a3a a3b
	rename birthday_1 birth_day
	label var birth_day "出生日期"
*户口
	codebook a18
	gen urban=0
	replace urban=1 if a18==2
	label var urban "城镇户口=1"
*民族：汉族=1 
	codebook a4
	gen hanzu=0
	replace  =1 if a4==1
	label var hanzu "汉族=1"

*婚姻:已婚=1
	codebook a69
	gen marry =0
	replace marry=1 if a69==3 |a69==4
	label var marry "已婚=1"
*性别
	codebook a2
	gen male=0
	replace male =1 if a2==1
	label var male "男性=1"

*健康状况
	tab a15,m
	label list a15lab
	clonevar health=a15
	replace health=. if health<0


*父母edu a89b a90b
	label list lab4
	gen fa_edu_h=.
	replace fa_edu_h =1 if a89b >=6
	replace fa_edu_h =0 if a89b <6
	label var fa_edu_h "父亲受教育程度在高中及以上"

	gen mo_edu_h=.
	replace mo_edu_h =1 if a90b >=6
	replace mo_edu_h =0 if a90b <6
	label var mo_edu_h "母亲受教育程度在高中及以上"
	
	save "$workingdir/CGSS2013.dta",replace 
	append using "$workingdir/CGSS2012.dta" ,force
	append using "$workingdir/CGSS2010.dta",force
	
	save "$workingdir/CGSS.dta",replace 

	use  "$workingdir/CGSS.dta",clear
	gen a ="1981sep01"
	gen time =date(a,"YMD")
	format %td time
	drop a 
	label var time "政策干预时点"	
	gen time1 = birth_day-time
	label var time1 "时间段"
	*保留在政策前后十年的人口
	keep if birth_day > d(01sep1971) & birth_day < d(01sep1991)
	tab time1,m
	keep if edu_year >=12 & edu_year !=.
	gen iv=0
	replace iv=1 if time1 >=0




	h binscatter
	binscatter edu_year time1  if time1>-2000 &time1< 2000 ,rd(0) n(100) linetype(lfit)
	binscatter health time1 if time1>-2000 &time1< 2000 ,rd(0) n(100) linetype(lfit)
	

	h cmogram 
	cmogram edu_year time1  if time1>-2000 &time1< 2000 , ///
		scatter cut(0) lineat(0) lfit ci(95) histopts(bin(25))

	cmogram health time1  if time1>-2000 &time1< 2000 , ///
		scatter cut(0) lineat(0) lfit ci(95) histopts(bin(25))


	ivreg2 health edu_year male urban hanzu marry (edu_year=iv)














