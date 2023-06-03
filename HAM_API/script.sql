create database HAM
go
use HAM
go
DROP DATABASE HAM
GO

create table tbl_role(
	id int primary key identity(0,1),
	role_name nvarchar(100),
)
go

create table tbl_department(
	id varchar(20) primary KEY,
	name nvarchar(200),
	description nvarchar(500),
	img Text
)

go
create table tbl_service(
	id varchar(20) primary key,
	name nvarchar(200),
	description nvarchar(300),
	price int
)
go

create table tbl_user(
	id varchar(20) primary key,
	username varchar(20),
	name nvarchar(100),
	pw nvarchar(20),
	email nvarchar(20),
	role_id int,
	p_number varchar(10),
	img text,
	constraint fk_role_id foreign key (role_id) references tbl_role(id)
)
go


create table tbl_patient(
	id varchar(20) primary key,
	pt_name nvarchar(100),
	dob date,
	gender char,
	job nvarchar(100),
	address nvarchar(300),
	user_id varchar(20),
	constraint fk_userid foreign key (user_id) references tbl_user(id),

)
go
create table tbl_patientRelative(
	id varchar(20) primary key,
	name nvarchar(100),
	address nvarchar(300),
	p_number varchar(10),
	pt_id varchar(20),
	constraint fk_pid foreign key (pt_id) references tbl_patient(id)
)
go


create table tbl_doctor(
	id varchar(20) primary key,
	name nvarchar(100),
	room nvarchar(100),
	dep_id varchar(20),
	user_id varchar(20),
	constraint fk_dep_id foreign key (dep_id) references tbl_department(id),
	constraint fk_user_id foreign key (user_id) references tbl_user(id)
)
go

create table tbl_booking(
	id varchar(20) primary key,
	order_num int,
	date DATE,
	time nvarchar(20),
	price int,
	status nvarchar(100),
	pt_id varchar(20),
	user_id varchar(20),
	dc_id varchar(20),
	sv_id varchar(20),
	constraint fk_pt_id foreign key (pt_id) references tbl_patient(id),
	constraint fk_uid foreign key (user_id) references tbl_user(id),
	constraint fk_dc_id foreign key (dc_id) references tbl_doctor(id),
	constraint fk_sv_id foreign key (sv_id) references tbl_service(id),
)
go
alter table tbl_booking alter column price int
go

create table tbl_prescription(
	id varchar(20) primary key,
	disease nvarchar(100),
	symptoms nvarchar(300),
	medicines nvarchar(500),
	ptu_medicines nvarchar(1000),
	user_id varchar(20),
	dc_id varchar(20),
	constraint fk_userid1 foreign key (user_id) references tbl_user(id),
	constraint fk_dcid foreign key (dc_id) references tbl_doctor(id)
)
go

create table tbl_news(
	id varchar(20) primary key,
	title nvarchar(200),
	body ntext,
	imgUrl ntext,
	postDate DATE
)

--insert into tbl_role (role_name) values ('Administrator')
--insert into tbl_role (role_name) values ('Doctor')
--insert into tbl_role (role_name) values ('User')

--GO
--INSERT [dbo].[tbl_booking] ([id], [order_num], [date], [time], [price], [status], [pt_id], [user_id], [dc_id], [sv_id]) VALUES (N'bk-0605c0052b324691b', 2, CAST(N'2023-05-31' AS Date), N'13h-14h', 1, N'Canceled', N'pt-ede15f89f1d045e5a', N'u-006de970-6bd1-4', N'dc-137ce4dfea8f4afb8', N'sv-5b92a79ebaa142fbb')
--INSERT [dbo].[tbl_booking] ([id], [order_num], [date], [time], [price], [status], [pt_id], [user_id], [dc_id], [sv_id]) VALUES (N'bk-44ac42161ceb4189a', 1, CAST(N'2023-05-31' AS Date), N'13h-14h', 1, N'Đã khám', N'pt-ede15f89f1d045e5a', N'u-006de970-6bd1-4', N'dc-137ce4dfea8f4afb8', N'sv-5b92a79ebaa142fbb')
--INSERT [dbo].[tbl_booking] ([id], [order_num], [date], [time], [price], [status], [pt_id], [user_id], [dc_id], [sv_id]) VALUES (N'bk-b12b3bda942044f59', 3, CAST(N'2023-05-31' AS Date), N'13h-14h', 0, N'Chờ khám', N'pt-ede15f89f1d045e5a', N'u-006de970-6bd1-4', N'dc-137ce4dfea8f4afb8', N'sv-5b92a79ebaa142fbb')
--GO
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-023321f2-224e-4', N'Khoa ung bướu', N'Khoa ung bướu là một trong những chuyên khoa quan trọng của phân ngành ngoại khoa, có chức năng chẩn đoán, điều trị, tầm soát ung thư và cung cấp đầy đủ các dịch vụ chăm sóc y tế cần thiết cho bệnh nhân ung thư bao gồm: hoá trị, xạ trị, điều trị ngoại khoa, điều trị nội khoa, ghép tế bào gốc...; đồng thời giúp kiểm soát các cơn đau bằng cách vật lý trị liệu, phong bế thần kinh ngoại biên, phong bế giao cảm,...', N'https://imgur.com/ib1BUys.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-2636213e-f6cc-4', N'Khoa phụ sản', N'Sản & Phụ khoa là chuyên khoa về sức khoẻ phụ nữ và các vấn đề liên quan tới bộ phận sinh sản nữ từ khi dậy thì cho đến hết cuộc đời. Khoa có hai lĩnh vực chủ yếu là: Khả năng sinh sản & sản khoa. Các bệnh phụ khoa.', N'https://imgur.com/mEQsGxH.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-293aa902-2d8d-4', N'Khoa nội tim mạch', N'Là phân khoa chuyên điều trị các bệnh lý tim mạch theo phương pháp nội khoa, bao gồm đặt stent động mạch, tiêm và dùng thuốc đặc trị hoặc nong van động mạch phổi bằng bóng qua da.', N'https://imgur.com/HqaQBX3.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-3dbaf6a3-af3f-4', N'Khoa da liễu', N'Khoa Da liễu là khoa chuyên điều trị các bệnh về da và những phần phụ của da (tóc, móng, tuyến mồ hôi…) Con người có thể mắc trên 3.000 loại bệnh về da khác nhau mà nguyên nhân là do chất kích thích, bị dị ứng, di truyền, mắc một số bệnh nào đó và hệ miễn dịch có vấn đề.', N'https://imgur.com/lh9lyto.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-699d3d11-0f20-4', N'Khoa thận TN-CXK', N'Nội thận là chuyên khoa thuộc khoa nội chịu trách nhiệm điều trị tất cả các bệnh lý liên quan đến thận và đường tiết niệu. Thận có vai trò quan trọng trong việc duy trì sự cân bằng điện giải và dung dịch nước trong cơ thể.', N'https://imgur.com/dFZs4yV.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-6b861f33-c6cd-4', N'Khoa nội tổng hợp', N'Chẩn đoán và điều trị bệnh nhân thuộc các chuyên khoa: Tiêu hóa, Nội tiết, Hô hấp, Tiết niệu, Thần kinh, Cơ xương khớp. Đào tạo, giảng dạy lâm sàng cho các đối tượng sau đại học: Nghiên cứu sinh, CK II, Cao học, Nội trú, CK I; Đại học.', N'https://imgur.com/o9Vsw6D.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-8f6e8ca0-72c1-4', N'Khoa truyền nhiễm', N'Khoa Truyền nhiễm cung cấp các dịch vụ lâm sàng tiên tiến để chẩn đoán và điều trị các loại bệnh truyền nhiễm hoặc tình trạng bệnh lý do các tác nhân truyền nhiễm (vi rút, vi khuẩn, ký sinh trùng hoặc nấm) gây ra.', N'https://imgur.com/exByrwd.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-aa7b943b-7c49-4', N'Khoa chấn thương', N'Khoa chấn thương chỉnh hình là chuyên khoa chuyên điều trị các chấn thương và tình trạng bệnh liên quan đến hệ thống cơ xương khớp, gồm xương, cơ, khớp và dây chằng. Tuổi tác, chấn thương, tư thế không đúng hoặc các môn thể thao va chạm mạnh có thể gây tổn thương đến những vùng này của cơ thể.', N'https://imgur.com/eqaCVT7.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-ab60a0aa-6d7d-4', N'Khoa thần kinh', N'Thần kinh học là một chuyên ngành y học chuyên nghiên cứu về sự rối loạn của hệ thần kinh. Đặc biệt, thần kinh học chú trọng vào việc chẩn đoán và điều trị các loại bệnh liên quan đến hệ thần kinh trung ương, hệ thần kinh ngoại biên và hệ thần kinh tự chủ.', N'https://imgur.com/aTsKERY.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-b72d5021-6511-4', N'Khoa phục hồi chức năng', N'Khoa Phục hồi chức năng là đơn vị điều trị ngoại trú cho những bệnh nhân là người lớn và trẻ em có các rối loạn về cơ xương khớp, thần kinh, tim mạch, hô hấp,…', N'https://imgur.com/n73spmm.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-d2b7cae4-d48d-4', N'Khoa nhi', N'Nhi khoa là một ngành của Y học chịu trách nhiệm chăm sóc sức khỏe cho trẻ em từ lúc mới sinh cho đến 14-21 tuổi, tùy thuộc vào mỗi Quốc gia. Ở Việt Nam Nhi khoa chăm sóc sức khỏe cho trẻ em từ sơ sinh đến dưới 15 tuổi. Bác sĩ thực hành trong lĩnh vực này được gọc là bác sĩ Nhi khoa', N'https://imgur.com/mVs37wL.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-d504182c-c79f-4', N'Khoa Y học Cổ truyền', N'Y học cổ truyền vận dụng chẩn trị theo các phương pháp Đông Y kết hợp với Y học hiện đại, và các phương pháp không dùng thuốc như châm cứu, điện châm, nhĩ châm, xoa bóp, bấm huyệt, giác hơi, khí công dưỡng sinh để điều trị có hiệu quả các bệnh lý về cơ xương khớp, rối loạn dẫn truyền thần kinh, di chứng tai biến mạch máu não, đau dây thần kinh.', N'https://imgur.com/BXSPV7Y.png')
--INSERT [dbo].[tbl_department] ([id], [name], [description], [img]) VALUES (N'dep-d96845c6-ca5b-4', N'Khoa tai mũi họng', N'Khoa Tai Mũi Họng là chuyên khoa điều trị các bệnh lý liên quan đến tai, mũi và họng cũng như vùng đầu và cổ. Khoa Tai Mũi Họng cung cấp dịch vụ đa dạng, từ khám bệnh đến thực hiện các loại phẫu thuật phức tạp cho cả trẻ em và người lớn.', N'https://imgur.com/D4sg48D.png')
--GO
--INSERT [dbo].[tbl_doctor] ([id], [name], [room], [dep_id], [imgUrl]) VALUES (N'dc-137ce4dfea8f4afb8', N'Bác sĩ Hải', N'NS-01', N'dep-d96845c6-ca5b-4', NULL)
--INSERT [dbo].[tbl_doctor] ([id], [name], [room], [dep_id], [imgUrl]) VALUES (N'dc-1defb958-637e-4', N'Trần Đức Băng', N'Phòng số 1', N'dep-8f6e8ca0-72c1-4', NULL)
--INSERT [dbo].[tbl_doctor] ([id], [name], [room], [dep_id], [imgUrl]) VALUES (N'dc-5aaefd72-2f46-4', N'Đỗ Thanh Vân', N'TK01', N'dep-ab60a0aa-6d7d-4', NULL)
--INSERT [dbo].[tbl_doctor] ([id], [name], [room], [dep_id], [imgUrl]) VALUES (N'dc-5ece3d22-ff0e-4', N'Nguyễn Khác Tiệp', N'Phòng số 1', N'dep-023321f2-224e-4', NULL)
--GO
--INSERT [dbo].[tbl_news] ([id], [title], [body], [imgUrl], [postDate]) VALUES (N'new08184621-838f-48b', N'PHẪU THUẬT CẮT GAN TẠI BỆNH VIỆN ĐA KHOA TỈNH HƯNG YÊN', N'Với sứ mệnh là người anh cả trong ngành y tế Hưng Yên, trong những năm gần đây khối Ngoại bệnh viện đa khoa tỉnh Hưng Yên đã khai phá rất nhiều kỹ thuật mới: Tán cạnh qua da, mổ bắt cột sống qua da, mổ cắt dạ dày, cắt đại tràng qua nội soi được triển khai rộng rãi. Hiện nay phẫu thuật cắt gan của khoa ngoại bụng cũng được phát triển. Bệnh nhân NTT 46 tuổi trú tại Nguyễn Trãi Ân Thi đã được chẩn đoán u gan qua thăm khám, phát hiện ra khối u gan bên trái có kích thước 59 x 50 mm. Bệnh nhân đã được phẫu thuật cắt phân thuỳ 2,3 trong khoảng thời gian 1 giờ, với các thiết bị hiện đại như dùng dao siêu âm và được làm giảm đau bên ngoài màng cứng. Cắt gan có sử dụng dao siêu âm, mặt cắt rất đẹp và rất ít chảy máu.|
--Nói đến phẫu thuật, không thể tách rời 1 bộ phận nhạc công đứng sau sân khấu, đội ngũ gây mê hồi sức. Với hầu hết các phẫu thuật lớn như: cắt gan, cắt dạy dỗ, cắt đại tràng, thay khớp háng, lệch xương đùi, đặc biệt đối với bệnh nhân già yếu, các bác sĩ gây mê hồi sức luôn lựa chọn phương pháp vô địch cảm tốt nhất, phương thức giảm đau sau mổ phù hợp nhất. Hồi sức nặng sau sốc điện, hay chấn thương sọ não không còn quá xa lạ với chúng tôi.|
-- Với trang thiết bị hiện đại, cùng đội ngũ bác sĩ phẫu thuật và gây mê hồi sức luôn không ngừng học hỏi và nâng cao chất lượng chuyên môn. Khi bạn đã lựa chọn đến với chúng tôi, nhất định chúng tôi sẽ không làm bạn thất vọng. Chúng tôi chắc chắn rằng chúng tôi sẽ có được niềm tin nơi các bạn.', N'https://baobariavungtau.com.vn/dataimages/202011/original/images1639321_Phau_thuat_tai_tao_vu_cho_nguoi_benh.JPG', CAST(N'2023-06-03' AS Date))
--INSERT [dbo].[tbl_news] ([id], [title], [body], [imgUrl], [postDate]) VALUES (N'newd0d42970-fd90-4c2', N'VÀI ĐIỀU CẦN BIẾT VỀ VACXIN COVID -19', N'Vaccine phòng COVID-19 AstraZeneca.|
--Vaccine này được tiêm cho người trên 18 tuổi. Thời gian tiêm giữa 2 mũi từ 8-12 tuần.|
--Hiệu quả bảo vệ sau tiêm mũi 1 đạt 76% và hiệu quả cao nhất sau 21 ngày. Đồng thời loại vaccine này cũng làm giảm 48,7% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Alpha; giảm 30% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Delta.|
--Sau khi hoàn thành 2 mũi tiêm sẽ đạt 82%, đồng thời giúp giảm 74.5% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Alpha; giảm 67% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Delta.|
--Vaccine phòng COVID-19 Pfizer|
--Đây là vaccine được chỉ định tiêm cho người trên 12 tuổi.|
-- Thời gian chờ giữa 2 mũi tiêm từ 3 đến 6 tuần.|
--Hiệu quả bảo vệ sau tiêm mũi 1 đạt 52%, đồng thời giúp giảm 47.5% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Alpha; giảm 35.6% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Delta.|
--Sau khi hoàn thành 2 mũi tiêm thì đạt 95% hiệu quả phòng bệnh, đồng thời giúp giảm 93.7% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Alpha; giảm 88% nguy cơ mắc COVID-19 có triệu chứng đối với biến chủng Delta.|
--Vaccine phòng COVID-19 Moderna|
--Vaccine này được tiêm cho người trên 18 tuổi. Thời gian chờ giữa 2 mũi từ 4-6 tuần. Hiệu quả đạt được sau 14 ngày tiêm mũi thứ 2 là 94.1%.|
--Ở người từ 65 tuổi trở lên nếu được tiêm đủ 2 mũi vaccine Moderna sẽ giúp giảm 86.4% nguy cơ mắc COVID-19 có triệu chứng.|
--Vaccine phòng COVID-19 Sputnik|
--Vaccine này được tiêm cho người trên 18 tuổi. Thời gian chờ giữa 2 mũi từ 3 tuần.|
--Sau tiềm liều đầu tiên 21 ngày, hiệu quả bảo vệ đạt 91,6%, và tăng lên 97,6% sau 35 ngày tiêm liều thứ nhất.|', N'https://bcp.cdnchinhphu.vn/334894974524682240/2022/4/23/vac-xin-covid-1629940068-16507103800332120491520.jpg', NULL)
--GO
--INSERT [dbo].[tbl_patient] ([id], [pt_name], [dob], [gender], [job], [address], [user_id]) VALUES (N'pt-ede15f89f1d045e5a', N'Thu Thao', CAST(N'2004-06-09' AS Date), N'0', N'Sinh Vien', N'Hung Yen', N'u-006de970-6bd1-4')
--GO
--SET IDENTITY_INSERT [dbo].[tbl_role] ON 

--INSERT [dbo].[tbl_role] ([id], [role_name]) VALUES (0, N'Administrator')
--INSERT [dbo].[tbl_role] ([id], [role_name]) VALUES (1, N'Doctor')
--INSERT [dbo].[tbl_role] ([id], [role_name]) VALUES (2, N'User')
--SET IDENTITY_INSERT [dbo].[tbl_role] OFF
--GO
--INSERT [dbo].[tbl_service] ([id], [name], [description], [price]) VALUES (N'sv-5b92a79ebaa142fbb', N'Khám thường (có BHYT)', N'Khám thường có bảo hiểm y tế sẽ được bảo hiểm hỗ trợ viện phí. Có thể đặt khám vào các ngày từ Thứ 2 đến Thứ 6 trong khung giờ làm việc của bệnh viện', 100000)
--INSERT [dbo].[tbl_service] ([id], [name], [description], [price]) VALUES (N'sv-b8eb5d8bdeb84c548', N'Khám thường (không BHYT)', N'Khám thường không có bảo hiểm y tế sẽ có phí cao hơn. Có thể đặt khám tại bệnh viện trong các ngày từ Thứ Hai đến Thứ Bảy.', 150000)
--GO
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-006de970-6bd1-4', N'thaohoang130', N'Hoàng Thị Thu Thảo', N'thao@13020', N'hoang.thao130@gmail.com', 2, N'0988469549', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-01fed16d-7754-4', N'tungnguyen723', N'Nguyễn Quốc Tùng', N'tung@7233', N'nguyen.tung723@gmail.com', 2, N'0985602086', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0239c9e4-e162-4', N'caonguyen566', N'Nguyễn Văn Cao', N'cao@56659', N'nguyen.cao566@gmail.com', 2, N'0984889074', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-02ae3edd-aca6-4', N'huedang562', N'Đặng Thị Huệ', N'hue@56275', N'dang.hue562@gmail.com', 2, N'0985027482', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-050a4c44-c16e-4', N'vanduong627', N'Dương Bùi Hồng Vân', N'van@62724', N'duong.van627@gmail.com', 2, N'0985154574', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0634648c-1604-4', N'nhinguyen450', N'Nguyễn Yến Nhi', N'nhi@45027', N'nguyen.nhi450@gmail.com', 2, N'0986801879', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0720f51f-d94b-4', N'namnguyen617', N'Nguyễn Văn Nam', N'nam@61767', N'nguyen.nam617@gmail.com', 2, N'0987282981', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-07532208-6ea7-4', N'nhinhluong211', N'Lương Thị Nhinh', N'nhinh@21178', N'luong.nhinh211@gmail.com', 2, N'0985109044', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-09852136-6232-4', N'anhnguyen475', N'Nguyễn Việt Anh', N'anh@47537', N'nguyen.anh475@gmail.com', 2, N'0985236910', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-09e49863-6d91-4', N'hieudo276', N'Đỗ Trung Hiếu', N'hieu@27640', N'do.hieu276@gmail.com', 2, N'0986661437', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0db58421-51ea-4', N'hoangnguyen159', N'Nguyễn Huy Hoàng', N'hoang@15950', N'nguyen.hoang159@gmail.com', 2, N'0988335870', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0df52f4c-f8ed-4', N'minhtran640', N'Trần Viết Minh', N'minh@64059', N'tran.minh640@gmail.com', 2, N'0983661567', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0e5de8a8-4293-4', N'giangphan285', N'Phan Trường Giang', N'giang@28534', N'phan.giang285@gmail.com', 2, N'0981565286', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0ea488f4-c4d5-4', N'anhnguyen825', N'Nguyễn Tuấn Anh', N'anh@8256', N'nguyen.anh825@gmail.com', 2, N'0982969092', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0f5d49e8-7989-4', N'longpham377', N'Phạm Nhật Long', N'long@37749', N'pham.long377@gmail.com', 2, N'0984197842', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0fcad7a6-80b1-4', N'biennguyen364', N'Nguyễn Văn Biển', N'bien@36498', N'nguyen.bien364@gmail.com', 2, N'0988331269', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-0ff5e833-7b82-4', N'datbui538', N'Bùi Thành Đạt', N'dat@53860', N'bui.dat538@gmail.com', 2, N'0986453436', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-102a693f-0cf6-4', N'hoangtran569', N'Trần Huy Hoàng', N'hoang@56989', N'tran.hoang569@gmail.com', 2, N'0983287868', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-107f8c3b-802d-4', N'namnguyen468', N'Nguyễn Hoài Nam', N'nam@46898', N'nguyen.nam468@gmail.com', 2, N'0982665872', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-10aa943b-5a27-4', N'thaotran330', N'Trần Phương Thảo', N'thao@33050', N'tran.thao330@gmail.com', 2, N'0984892091', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-11525c5e-b200-4', N'cuongla902', N'Lã Quang Cường', N'cuong@90271', N'la.cuong902@gmail.com', 2, N'0989858372', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-11ae7541-c6fd-4', N'nghiapham213', N'Phạm Văn Nghĩa', N'nghia@21341', N'pham.nghia213@gmail.com', 2, N'0989916825', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1204c4b3-8c13-4', N'vietnguyen576', N'Nguyễn Quốc Việt', N'viet@57624', N'nguyen.viet576@gmail.com', 2, N'0983133738', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1296631c-eb46-4', N'chinguyen368', N'Nguyễn Linh Chi', N'chi@36869', N'nguyen.chi368@gmail.com', 2, N'0986237626', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-12fb2838-f01a-4', N'tule208', N'Lê Xuân Tú', N'tu@20861', N'le.tu208@gmail.com', 2, N'0989213594', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1394efc5-da9f-4', N'hoangnguyen415', N'Nguyễn Minh Hoàng', N'hoang@41527', N'nguyen.hoang415@gmail.com', 2, N'0986842418', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-14302b72-61c1-4', N'thuydang618', N'Đặng Thị Thu Thùy', N'thuy@61882', N'dang.thuy618@gmail.com', 2, N'0981291278', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1542c918-8c1e-4', N'nganguyen427', N'Nguyễn Thị Nga', N'nga@42785', N'nguyen.nga427@gmail.com', 2, N'0989013612', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-15bf8e2c-3d8d-4', N'vinhnguyen136', N'Nguyễn Văn Vinh', N'vinh@1364', N'nguyen.vinh136@gmail.com', 2, N'0987612326', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-15ffa0f2-dcce-4', N'linhnguyen284', N'Nguyễn Hữu Linh', N'linh@28472', N'nguyen.linh284@gmail.com', 2, N'0986184209', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-18ecff35-134f-4', N'tuanle131', N'Lê Hoàng Tuấn', N'tuan@13144', N'le.tuan131@gmail.com', 2, N'0989033558', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-19257919-e6e7-4', N'huongto936', N'Tô Thị Hương', N'huong@93688', N'to.huong936@gmail.com', 2, N'0986039893', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-19541b90-a9ec-4', N'vanle658', N'Lê Thị Trà Vân', N'van@65889', N'le.van658@gmail.com', 2, N'0987170408', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1a390a17-3cb5-4', N'thuha431', N'Hà Quỳnh Thu', N'thu@43116', N'ha.thu431@gmail.com', 2, N'0987884507', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1aac4b67-9693-4', N'chungnguyen284', N'Nguyễn Văn Chung', N'chung@28427', N'nguyen.chung284@gmail.com', 2, N'0986023234', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1abfcbdc-35d6-4', N'thuynguyen939', N'Nguyễn Duy Thuy', N'thuy@93989', N'nguyen.thuy939@gmail.com', 2, N'0984008166', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1b1a341d-92b2-4', N'phuongnguyen487', N'Nguyễn Thị Minh Phượng', N'phuong@48771', N'nguyen.phuong487@gmail.com', 2, N'0984810977', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1c3c618a-3769-4', N'thuyvu770', N'Vũ Thị Thùy', N'thuy@77077', N'vu.thuy770@gmail.com', 2, N'0986121876', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-1fe386de-0220-4', N'phucdao334', N'Đào Minh Phúc', N'phuc@33417', N'dao.phuc334@gmail.com', 2, N'0984786734', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-210afcaa-ce4f-4', N'truongle126', N'Lê Văn Trường', N'truong@12617', N'le.truong126@gmail.com', 2, N'0988507576', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-21f1164b-d7cb-4', N'truongle139', N'Lê Văn Trường', N'truong@1396', N'le.truong139@gmail.com', 2, N'0988360260', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2220ffbf-30d3-4', N'binhduong871', N'Dương Văn Bình', N'binh@87113', N'duong.binh871@gmail.com', 2, N'0989996427', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2320db49-d742-4', N'linhdo826', N'Đỗ Thị Mỹ Linh', N'linh@82655', N'do.linh826@gmail.com', 2, N'0985744071', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2348d323-583b-4', N'thangvu196', N'Vũ Văn Thắng', N'thang@19653', N'vu.thang196@gmail.com', 2, N'0981573067', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2354331a-0011-4', N'ducpham445', N'Phạm Việt Đức', N'duc@44586', N'pham.duc445@gmail.com', 2, N'0989559250', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2363045b-a25f-4', N'trangpham502', N'Phạm Thị Huyền Trang', N'trang@50220', N'pham.trang502@gmail.com', 2, N'0987569698', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-240ed8c7-2c10-4', N'vinhnguyen569', N'Nguyễn Thành Vinh', N'vinh@56977', N'nguyen.vinh569@gmail.com', 2, N'0982455245', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2415966f-fb57-4', N'haonguyen952', N'Nguyễn Thị Hảo', N'hao@95275', N'nguyen.hao952@gmail.com', 2, N'0984774219', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-269fff5b-dda3-4', N'lamnguyen886', N'Nguyễn Văn Lâm', N'lam@88651', N'nguyen.lam886@gmail.com', 2, N'0987710801', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2907e13a-0c61-4', N'baomai383', N'Mai Hoàng Thái Bảo', N'bao@38346', N'mai.bao383@gmail.com', 2, N'0987196324', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-29b8964e-666e-4', N'bangho139', N'Hồ Lâm Bằng', N'bang@13952', N'ho.bang139@gmail.com', 2, N'0989514549', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2b4f1113-8440-4', N'hieule249', N'Lê Minh Hiếu', N'hieu@24978', N'le.hieu249@gmail.com', 2, N'0988922891', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2bce1c35-49a7-4', N'tuvu753', N'Vũ Văn Tú', N'tu@75327', N'vu.tu753@gmail.com', 2, N'0988215686', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2bd5300c-0810-4', N'kiennguyen903', N'Nguyễn Văn Kiên', N'kien@90323', N'nguyen.kien903@gmail.com', 2, N'0984825351', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2c7ac226-c468-4', N'thangnguyen344', N'Nguyễn Văn Thắng', N'thang@34410', N'nguyen.thang344@gmail.com', 2, N'0983630271', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2cc504c4-8712-4', N'vunguyen623', N'Nguyễn Tuấn Vũ', N'vu@6237', N'nguyen.vu623@gmail.com', 2, N'0981566857', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2cd54af8-85d2-4', N'bagiang264', N'Giang Sơn Bá', N'ba@26466', N'giang.ba264@gmail.com', 2, N'0982021508', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-2d5b4de5-68f2-4', N'anhhoang917', N'Hoàng Trung Anh', N'anh@9170', N'hoang.anh917@gmail.com', 2, N'0989650914', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-327a6bd8-cece-4', N'hoangpham956', N'Phạm Gia Hoàng', N'hoang@95652', N'pham.hoang956@gmail.com', 2, N'0985292530', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-32cebec4-d4c2-4', N'longchu339', N'Chu Hải Long', N'long@33911', N'chu.long339@gmail.com', 2, N'0982980385', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-32f0dcde-11f5-4', N'sangpham256', N'Phạm Ngọc Sáng', N'sang@25682', N'pham.sang256@gmail.com', 2, N'0985439092', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-33968afe-703f-4', N'sieuto526', N'Tô Xuân Siêu', N'sieu@52670', N'to.sieu526@gmail.com', 2, N'0989062202', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-33d46fee-8870-4', N'hiepduong701', N'Dương Ngọc Hiệp', N'hiep@70112', N'duong.hiep701@gmail.com', 2, N'0988035998', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-35de8b67-1755-4', N'tientran702', N'Trần Thủy Tiên', N'tien@70281', N'tran.tien702@gmail.com', 2, N'0989555809', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-3890d935-2b83-4', N'daodang831', N'Đặng Văn Đạo', N'dao@8311', N'dang.dao831@gmail.com', 2, N'0986641345', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-3a4f85b2-8750-4', N'kientran962', N'Trần Thế Kiên', N'kien@9628', N'tran.kien962@gmail.com', 2, N'0981875225', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-3a6c38c1-9b12-4', N'toanle708', N'Lê Thanh Toàn', N'toan@70823', N'le.toan708@gmail.com', 2, N'0988176505', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-3ae94ced-248a-4', N'phongmai449', N'Mai Huy Phong', N'phong@44919', N'mai.phong449@gmail.com', 2, N'0981127502', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-3f2a0d11-8181-4', N'haodoan236', N'Đoàn Đình Hào', N'hao@23610', N'doan.hao236@gmail.com', 2, N'0981938868', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-3fbb5eaa-4e83-4', N'duongtran704', N'Trần Thanh Dương', N'duong@70450', N'tran.duong704@gmail.com', 2, N'0986152787', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-40903d82-f1dd-4', N'chinhnguyen864', N'Nguyễn Đăng Chính', N'chinh@86490', N'nguyen.chinh864@gmail.com', 2, N'0989085574', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-425b467d-16ab-4', N'cuonghoang831', N'Hoàng Mạnh Cường', N'cuong@83185', N'hoang.cuong831@gmail.com', 2, N'0982801463', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-426157cc-b4e1-4', N'anhvu971', N'Vũ Tuấn Anh', N'anh@97168', N'vu.anh971@gmail.com', 2, N'0985284243', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-44ead832-1182-4', N'hieupham281', N'Phạm Minh Hiếu', N'hieu@28146', N'pham.hieu281@gmail.com', 2, N'0985088929', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-45199fe1-96bd-4', N'toantrinh651', N'Trịnh Văn Toàn', N'toan@65121', N'trinh.toan651@gmail.com', 2, N'0985258853', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-497129d9-97e7-4', N'khuenguyen182', N'Nguyễn Gia Khuê', N'khue@18229', N'nguyen.khue182@gmail.com', 2, N'0986828099', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4a844e47-8dfb-4', N'congvu178', N'Vũ Thành Công', N'cong@17855', N'vu.cong178@gmail.com', 2, N'0986693103', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4ac1b674-e4c4-4', N'linhnguyen881', N'Nguyễn Văn Linh', N'linh@88154', N'nguyen.linh881@gmail.com', 2, N'0987751608', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4ae85b60-c8bd-4', N'anhnguyen677', N'Nguyễn Đức Tuấn Anh', N'anh@67733', N'nguyen.anh677@gmail.com', 2, N'0982784989', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4c405e7f-2f2b-4', N'tiennguyen270', N'Nguyễn Minh Tiến', N'tien@27092', N'nguyen.tien270@gmail.com', 2, N'0989498477', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4d0c41f1-adfc-4', N'anhpham193', N'Phạm Quang Anh', N'anh@19337', N'pham.anh193@gmail.com', 2, N'0987381265', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4d0d4d72-5d88-4', N'quangle476', N'Lê Vinh Quang', N'quang@47629', N'le.quang476@gmail.com', 2, N'0987951384', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4d3c8f9c-46cc-4', N'quannguyen123', N'Nguyễn Quân', N'quan@12343', N'nguyen.quan123@gmail.com', 2, N'0981989489', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4e144686-76f0-4', N'namnguyen404', N'Nguyễn Thanh Nam', N'nam@40490', N'nguyen.nam404@gmail.com', 2, N'0982468616', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4eb81346-0b7e-4', N'anhvu171', N'Vũ Kim Anh', N'anh@17162', N'vu.anh171@gmail.com', 2, N'0983402479', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-4f2a172c-bd94-4', N'yenle248', N'Lê Thị Yến', N'yen@24845', N'le.yen248@gmail.com', 2, N'0989555413', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-518f557f-a163-4', N'thuanbo792', N'Bồ Đào Thuận', N'thuan@7921', N'bo.thuan792@gmail.com', 2, N'0982217073', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-51ef154f-1745-4', N'huongnguyen822', N'Nguyễn Thị Mai Hương', N'huong@82254', N'nguyen.huong822@gmail.com', 2, N'0987916762', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-52373dba-3c93-4', N'quangtran538', N'Trần Văn Quang', N'quang@53879', N'tran.quang538@gmail.com', 2, N'0989706472', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5263ddf4-533f-4', N'chiennguyen475', N'Nguyễn Văn Chiến', N'chien@47588', N'nguyen.chien475@gmail.com', 2, N'0988498813', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-538ab936-41ec-4', N'nendao154', N'Đào Thị Nền', N'nen@15452', N'dao.nen154@gmail.com', 2, N'0981974468', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-539e749b-256f-4', N'vando286', N'Đỗ Thị Vân', N'van@28698', N'do.van286@gmail.com', 2, N'0981377495', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-53ac11d0-4fcf-4', N'nghiatrinh940', N'Trịnh Xuân Nghĩa', N'nghia@94045', N'trinh.nghia940@gmail.com', 2, N'0983553472', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-546ee9b1-1acb-4', N'quyetdoan696', N'Đoàn Văn Quyết', N'quyet@69642', N'doan.quyet696@gmail.com', 2, N'0983642489', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-548b15ef-5d75-4', N'huynhngo303', N'Ngô Quang Huỳnh', N'huynh@30352', N'ngo.huynh303@gmail.com', 2, N'0988846471', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-54cb9d8b-e9d0-4', N'anhchu590', N'Chu Trần Quốc Anh', N'anh@59016', N'chu.anh590@gmail.com', 2, N'0989082482', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-54eb32a6-2bad-4', N'minhpham320', N'Phạm Văn Minh', N'minh@32032', N'pham.minh320@gmail.com', 2, N'0986887385', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-558a0067-62ce-4', N'trangdo656', N'Đỗ Thị Trang', N'trang@65680', N'do.trang656@gmail.com', 2, N'0982763433', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-563ab2e4-7b19-4', N'quynhhoang748', N'Hoàng Quý Quỳnh', N'quynh@7483', N'hoang.quynh748@gmail.com', 2, N'0982471103', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5660184f-88a9-4', N'trangdo639', N'Đỗ Thị Thùy Trang', N'trang@63942', N'do.trang639@gmail.com', 2, N'0984988841', N'https://imgur.com/yWLxOxv.png')
--GO
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-570103e1-da84-4', N'linhtran786', N'Trần Văn Linh', N'linh@78625', N'tran.linh786@gmail.com', 2, N'0987526258', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-57990910-08df-4', N'hieuhoang608', N'Hoàng Trung Hiếu', N'hieu@60871', N'hoang.hieu608@gmail.com', 2, N'0988793415', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5995489e-7d95-4', N'dungtruong136', N'Trương Văn Dũng', N'dung@1360', N'truong.dung136@gmail.com', 2, N'0989274283', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-59a94cde-4436-4', N'ngochoang649', N'Hoàng Thị Ngọc', N'ngoc@64925', N'hoang.ngoc649@gmail.com', 2, N'0981419416', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5a7c607a-9b4c-4', N'datdo804', N'Đỗ Văn Đạt', N'dat@8040', N'do.dat804@gmail.com', 2, N'0988467902', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5aaf898a-6698-4', N'huyendao967', N'Đào Thị Thanh Huyền', N'huyen@96748', N'dao.huyen967@gmail.com', 2, N'0986748582', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5b105276-df1d-4', N'yenchu851', N'Chu Thị Kim Yến', N'yen@8517', N'chu.yen851@gmail.com', 2, N'0982403369', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5b99228b-0246-4', N'anhle611', N'Lê Thị Mai Anh', N'anh@61112', N'le.anh611@gmail.com', 2, N'0983789430', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5ba1a11b-a452-4', N'phongnguyen720', N'Nguyễn Văn Phong', N'phong@72035', N'nguyen.phong720@gmail.com', 2, N'0983134146', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5bcd4799-231b-4', N'hiepluu235', N'Lưu Văn Hiệp', N'hiep@23566', N'luu.hiep235@gmail.com', 2, N'0987092686', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5ca413af-2ad0-4', N'hieudoan490', N'Đoàn Trung Hiếu', N'hieu@49080', N'doan.hieu490@gmail.com', 2, N'0983461010', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5dab5270-2ba2-4', N'hieungo878', N'Ngô Trung Hiếu', N'hieu@87830', N'ngo.hieu878@gmail.com', 2, N'0983678068', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5f0deca5-e344-4', N'haobui671', N'Bùi Kim Hào', N'hao@67198', N'bui.hao671@gmail.com', 2, N'0981295318', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-5fb3e448-fefc-4', N'manhle698', N'Lê Trọng Mạnh', N'manh@69844', N'le.manh698@gmail.com', 2, N'0987175393', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-60564dc8-87f8-4', N'thiempham942', N'Phạm Ngọc Thiêm', N'thiem@94214', N'pham.thiem942@gmail.com', 2, N'0988914811', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-6151191a-5d53-4', N'anhtuong378', N'Tường Thế Hải Anh', N'anh@37835', N'tuong.anh378@gmail.com', 2, N'0988181437', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-626d0abe-3904-4', N'kiendinh840', N'Đinh Văn Kiên', N'kien@8406', N'dinh.kien840@gmail.com', 2, N'0988406106', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-65ba79aa-aee9-4', N'longly193', N'Lý Thành Long', N'long@19380', N'ly.long193@gmail.com', 2, N'0988354935', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-6774ad6f-f8a0-4', N'namluyen607', N'Luyện Ngọc Nam', N'nam@60710', N'luyen.nam607@gmail.com', 2, N'0981137162', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-6ac8a95e-a5ec-4', N'thanhdo430', N'Đỗ Thế Thành', N'thanh@43015', N'do.thanh430@gmail.com', 2, N'0989204600', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-6c03aa9e-2227-4', N'tiennguyen439', N'Nguyễn Thị Thùy Tiên', N'tien@43924', N'nguyen.tien439@gmail.com', 2, N'0981242090', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-6c640b41-3cd0-4', N'tubui169', N'Bùi Văn Tú', N'tu@16995', N'bui.tu169@gmail.com', 2, N'0981507857', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-6f3c566a-01ff-4', N'khiennguyen375', N'Nguyễn Huy Khiến', N'khien@37554', N'nguyen.khien375@gmail.com', 2, N'0984341205', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-70d7bde0-fc0b-4', N'hieuvu125', N'Vũ Minh Hiếu', N'hieu@12524', N'vu.hieu125@gmail.com', 2, N'0982897655', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-71e09ac3-8909-4', N'hoangnguyen423', N'Nguyễn Huy Hoàng', N'hoang@42347', N'nguyen.hoang423@gmail.com', 2, N'0985577007', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-72ef32bc-93f1-4', N'sonle197', N'Lê Hồng Sơn', N'son@19767', N'le.son197@gmail.com', 2, N'0985473036', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-72f291aa-01dd-4', N'hieuhua707', N'Hứa Minh Hiếu', N'hieu@70772', N'hua.hieu707@gmail.com', 2, N'0981633744', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-737d9373-2e18-4', N'ninhnguyen636', N'Nguyễn Quang Ninh', N'ninh@63664', N'nguyen.ninh636@gmail.com', 2, N'0982484002', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-75b5b9d7-94b8-4', N'chungdo214', N'Đỗ Anh Chung', N'chung@21475', N'do.chung214@gmail.com', 2, N'0985697458', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-786b907f-0a26-4', N'lampham792', N'Phạm Duy Lâm', N'lam@79286', N'pham.lam792@gmail.com', 2, N'0987264486', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7aee9899-859e-4', N'huyduong485', N'Dương Đức Huy', N'huy@4850', N'duong.huy485@gmail.com', 2, N'0984427259', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7ba9b709-e1c3-4', N'kienle104', N'Lê Trung Kiên', N'kien@10446', N'le.kien104@gmail.com', 2, N'0983144736', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7bb8fe4b-3b5a-4', N'thaodao598', N'Đào Thị Thảo', N'thao@59885', N'dao.thao598@gmail.com', 2, N'0982525078', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7c475db1-18ba-4', N'chiennguyen223', N'Nguyễn Hợp Chiến', N'chien@22312', N'nguyen.chien223@gmail.com', 2, N'0981821119', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7cb50a74-c850-4', N'nhungnguyen426', N'Nguyễn Thị Nhung', N'nhung@42620', N'nguyen.nhung426@gmail.com', 2, N'0983590219', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7cb5c9e4-b9b8-4', N'manhtran197', N'Trần Văn Mạnh', N'manh@19799', N'tran.manh197@gmail.com', 2, N'0987979109', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7cdb2033-5a44-4', N'dungvu774', N'Vũ Chung Dũng', N'dung@77454', N'vu.dung774@gmail.com', 2, N'0988657989', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7d966f40-0bd4-4', N'vietdo407', N'Đỗ Quang Việt', N'viet@40751', N'do.viet407@gmail.com', 2, N'0989556792', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7e1516ea-6d56-4', N'dungnguyen503', N'Nguyễn Trọng Dũng', N'dung@50322', N'nguyen.dung503@gmail.com', 2, N'0983544034', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7eac792b-c725-4', N'baogiang458', N'Giang Gia Bảo', N'bao@45853', N'giang.bao458@gmail.com', 2, N'0988470150', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7f131c57-69ee-4', N'tanpham348', N'Phạm Ngọc Tân', N'tan@34830', N'pham.tan348@gmail.com', 2, N'0986700044', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-7f2c7f57-1191-4', N'nambui214', N'Bùi Phương Nam', N'nam@2147', N'bui.nam214@gmail.com', 2, N'0981081008', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-803c7482-6007-4', N'lunguyen276', N'Nguyễn Thị Lữ', N'lu@27675', N'nguyen.lu276@gmail.com', 2, N'0986502128', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-80bf6520-633f-4', N'thangle652', N'Lê Hữu Thắng', N'thang@65247', N'le.thang652@gmail.com', 2, N'0985741373', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-81b31ae7-04a0-4', N'anhnguyen276', N'Nguyễn Đình Quang Anh', N'anh@27669', N'nguyen.anh276@gmail.com', 2, N'0989441012', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-81c989ea-4d29-4', N'hieunguyen722', N'Nguyễn Đức Hiếu', N'hieu@72216', N'nguyen.hieu722@gmail.com', 2, N'0989624971', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-81d2d08f-50fa-4', N'nghiadao387', N'Đào Thị Nghĩa', N'nghia@38770', N'dao.nghia387@gmail.com', 2, N'0987140358', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-820cb3c5-5c1b-4', N'linhnguyen522', N'Nguyễn Thị Linh', N'linh@52292', N'nguyen.linh522@gmail.com', 2, N'0985353363', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-82bcfe3c-b189-4', N'sondang262', N'Đặng Văn Sơn', N'son@2627', N'dang.son262@gmail.com', 2, N'0984793871', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-82f0782b-dcee-4', N'hunghoang199', N'Hoàng Thái Hưng', N'hung@19983', N'hoang.hung199@gmail.com', 2, N'0984613302', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8368969a-7a28-4', N'dattran461', N'Trần Văn Đạt', N'dat@46162', N'tran.dat461@gmail.com', 2, N'0988258723', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-83956802-6e1e-4', N'datnguyen334', N'Nguyễn Mạnh Đạt', N'dat@3347', N'nguyen.dat334@gmail.com', 2, N'0982713843', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-845cfeb7-60df-4', N'datdang745', N'Đặng Tuấn Đạt', N'dat@74570', N'dang.dat745@gmail.com', 2, N'0989190515', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-85c0b38b-8869-4', N'hieuvu331', N'Vũ Minh Hiếu', N'hieu@3318', N'vu.hieu331@gmail.com', 2, N'0989745706', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-862dd836-2d54-4', N'nhatbui128', N'Bùi Long Nhật', N'nhat@12821', N'bui.nhat128@gmail.com', 2, N'0987070499', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8777b8e4-e2fd-4', N'minhnguyen982', N'Nguyễn Chiến Minh', N'minh@98298', N'nguyen.minh982@gmail.com', 2, N'0989506586', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-878d10fe-241a-4', N'eelcud', N'Pham Van Duc', N'123456', N'duclee.dzz@gmail.com', 0, N'0912456789', N'https://i.ebayimg.com/images/g/KIYAAOSwVblcbUkB/s-l1600.jpg')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-87ace020-777b-4', N'minhdinh514', N'Đinh Ngọc Minh', N'minh@51498', N'dinh.minh514@gmail.com', 2, N'0982664282', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8978829f-68c0-4', N'tuanpham904', N'Phạm Anh Tuấn', N'tuan@90433', N'pham.tuan904@gmail.com', 2, N'0989203792', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-899c4fe7-385e-4', N'thangle545', N'Lê Thanh Thăng', N'thang@54598', N'le.thang545@gmail.com', 2, N'0986706003', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8c3df30a-b00d-4', N'sonnguyen714', N'Nguyễn Cư Sơn', N'son@71423', N'nguyen.son714@gmail.com', 2, N'0988845727', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8d32416a-c1d5-4', N'huyha175', N'Hà Tài Huy', N'huy@17549', N'ha.huy175@gmail.com', 2, N'0981768933', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8ec20464-fc39-4', N'huycao181', N'Cao Xuân Huy', N'huy@18127', N'cao.huy181@gmail.com', 2, N'0989039857', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8eda6da3-a699-4', N'anhtran641', N'Trần Thị Ngọc Anh', N'anh@64121', N'tran.anh641@gmail.com', 2, N'0984904956', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-8f32b4dc-6fea-4', N'haudinh692', N'Đinh Xuân Hậu', N'hau@69279', N'dinh.hau692@gmail.com', 2, N'0984176916', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-91ad362d-f473-4', N'thuyvu350', N'Vũ Ngọc Thụy', N'thuy@35080', N'vu.thuy350@gmail.com', 2, N'0982483659', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-96555469-1721-4', N'thuydoan833', N'Đoàn Thị Bích Thùy', N'thuy@83357', N'doan.thuy833@gmail.com', 2, N'0987728606', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-96bbeea2-a7ad-4', N'hieunguyen835', N'Nguyễn Trung Hiếu', N'hieu@83543', N'nguyen.hieu835@gmail.com', 2, N'0986766521', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-973aed6b-2ab7-4', N'lando219', N'Đỗ Minh Lân', N'lan@21985', N'do.lan219@gmail.com', 2, N'0986064288', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-981cb8bd-99b7-4', N'hoangngo401', N'Ngô Văn Hoàng', N'hoang@40124', N'ngo.hoang401@gmail.com', 2, N'0989295207', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-9940e706-f508-4', N'luado108', N'Đỗ Thị Lụa', N'lua@10825', N'do.lua108@gmail.com', 2, N'0981866099', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-994a99db-8eff-4', N'binhtran779', N'Trần Xuân Bình', N'binh@7794', N'tran.binh779@gmail.com', 2, N'0985631437', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-99be01e0-57e6-4', N'thaonguyen917', N'Nguyễn Thị Thảo', N'thao@9179', N'nguyen.thao917@gmail.com', 2, N'0989236859', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-99f26b1c-acb8-4', N'longnguyen987', N'Nguyễn Phi Long', N'long@98780', N'nguyen.long987@gmail.com', 2, N'0983127103', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-9c84e93a-3f1a-4', N'toantruong758', N'Trương Tất Toàn', N'toan@75813', N'truong.toan758@gmail.com', 2, N'0983365919', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-9cb2623b-b0c9-4', N'quangnguyen260', N'Nguyễn Đình Quang', N'quang@26015', N'nguyen.quang260@gmail.com', 2, N'0989457781', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-9cd29f90-098b-4', N'dungnguyen506', N'Nguyễn Danh Tiến Dũng', N'dung@50653', N'nguyen.dung506@gmail.com', 2, N'0986090275', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-9d56adf2-0d1f-4', N'chungnguyen952', N'Nguyễn Hữu Chung', N'chung@9523', N'nguyen.chung952@gmail.com', 2, N'0982998725', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-9d62a7c6-6c4c-4', N'tuanvu523', N'Vũ Việt Tuấn', N'tuan@52382', N'vu.tuan523@gmail.com', 2, N'0984164248', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-9fd5f94b-85f6-4', N'quyetchu229', N'Chu Văn Quyết', N'quyet@22913', N'chu.quyet229@gmail.com', 2, N'0982229521', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a05b3bfd-c776-4', N'hungtran429', N'Trần Hữu Hưng', N'hung@42986', N'tran.hung429@gmail.com', 2, N'0981093215', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a15e0b19-d56b-4', N'manhnguyen933', N'Nguyễn Đức Mạnh', N'manh@93371', N'nguyen.manh933@gmail.com', 2, N'0982886056', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a1e418cc-de6f-4', N'hieutran246', N'Trần Trung Hiếu', N'hieu@2460', N'tran.hieu246@gmail.com', 2, N'0982089297', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a215f491-b910-4', N'thinhpham729', N'Phạm Đức Thịnh', N'thinh@72964', N'pham.thinh729@gmail.com', 2, N'0984038159', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a265df07-713e-4', N'huynguyen430', N'Nguyễn Quang Huy', N'huy@4308', N'nguyen.huy430@gmail.com', 2, N'0981162210', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a28bed6e-d32c-4', N'huule683', N'Lê Chiến Hữu', N'huu@68386', N'le.huu683@gmail.com', 2, N'0981115217', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a34f1b65-8823-4', N'dongnguyen461', N'Nguyễn Phương Đông', N'dong@46120', N'nguyen.dong461@gmail.com', 2, N'0983494755', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a8089806-76d7-4', N'nghiado848', N'Đỗ Văn Nghĩa', N'nghia@8483', N'do.nghia848@gmail.com', 2, N'0989566822', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a8092fd5-3cc8-4', N'duongnguyen950', N'Nguyễn Tùng Dương', N'duong@95038', N'nguyen.duong950@gmail.com', 2, N'0982136585', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a9ce565f-9c09-4', N'dungphan816', N'Phan Tấn Dũng', N'dung@81660', N'phan.dung816@gmail.com', 2, N'0983616247', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-a9e140b5-20dd-4', N'sinhhoang832', N'Hoàng Ngọc Sinh', N'sinh@8321', N'hoang.sinh832@gmail.com', 2, N'0986582605', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ab2cd6e8-02e8-4', N'thanhnguyen945', N'Nguyễn Tuấn Thành', N'thanh@94559', N'nguyen.thanh945@gmail.com', 2, N'0987487023', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ab3870a7-b18d-4', N'duongvu695', N'Vũ Văn Dương', N'duong@69536', N'vu.duong695@gmail.com', 2, N'0989523967', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-abe33506-d4a1-4', N'ngocle216', N'Lê Thanh Ngọc', N'ngoc@21644', N'le.ngoc216@gmail.com', 2, N'0989843635', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-abe5b5c1-54d3-4', N'thanhdang349', N'Đặng Thị Thanh', N'thanh@34931', N'dang.thanh349@gmail.com', 2, N'0983095066', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ad4958e8-a7ec-4', N'chucdoan238', N'Đoàn Thị Chúc', N'chuc@23842', N'doan.chuc238@gmail.com', 2, N'0983073552', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ae639dd9-3f93-4', N'hoannguyen792', N'Nguyễn Quang Hoàn', N'hoan@79241', N'nguyen.hoan792@gmail.com', 2, N'0982981350', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-b09f5c23-c0f2-4', N'toanle647', N'Lê Quốc Toàn', N'toan@64789', N'le.toan647@gmail.com', 2, N'0987865870', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-b0c205f2-1700-4', N'trangdo443', N'Đỗ Thùy Trang', N'trang@44323', N'do.trang443@gmail.com', 2, N'0989949006', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-b18e7848-e913-4', N'huyngo845', N'Ngô Quốc Huy', N'huy@8451', N'ngo.huy845@gmail.com', 2, N'0981064736', N'https://imgur.com/yWLxOxv.png')
--GO
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-b32e800d-2082-4', N'datnguyen244', N'Nguyễn Quang Đạt', N'dat@2444', N'nguyen.dat244@gmail.com', 2, N'0981722334', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-b72d2418-dea5-4', N'cuongbui937', N'Bùi Mạnh Cường', N'cuong@93760', N'bui.cuong937@gmail.com', 2, N'0981474971', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-b9e5e737-043f-4', N'tientrinh497', N'Trịnh Minh Tiến', N'tien@49773', N'trinh.tien497@gmail.com', 2, N'0985312720', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bb4db9cd-3df8-4', N'tuantran655', N'Trần Anh Tuấn', N'tuan@65524', N'tran.tuan655@gmail.com', 2, N'0985853092', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bb63efa1-d3e1-4', N'sonnguyen715', N'Nguyễn Khắc Sơn', N'son@71564', N'nguyen.son715@gmail.com', 2, N'0982908040', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bc002f40-8481-4', N'hongnguyen220', N'Nguyễn Phú Hồng', N'hong@22046', N'nguyen.hong220@gmail.com', 2, N'0986062408', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bc908861-525c-4', N'hoangnguyen147', N'Nguyễn Công Hoàng', N'hoang@14746', N'nguyen.hoang147@gmail.com', 2, N'0985140711', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bc9cf71a-17e8-4', N'minhdo927', N'Đỗ Công Minh', N'minh@92711', N'do.minh927@gmail.com', 2, N'0986272244', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bdfa0b81-f08d-4', N'giangluu453', N'Lưu Thị Giang', N'giang@45330', N'luu.giang453@gmail.com', 2, N'0986294414', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-be0f37f9-7380-4', N'hongvu485', N'Vũ Thị Hồng', N'hong@48538', N'vu.hong485@gmail.com', 2, N'0981574395', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-beca5c35-cf90-4', N'hoadao684', N'Đào Thị Hòa', N'hoa@6849', N'dao.hoa684@gmail.com', 2, N'0988224537', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bf1caab0-b53f-4', N'thaobui108', N'Bùi Hương Thảo', N'thao@10837', N'bui.thao108@gmail.com', 2, N'0985864068', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-bf23aaba-d081-4', N'sonta721', N'Tạ Thái Sơn', N'son@72167', N'ta.son721@gmail.com', 2, N'0981767351', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c0f16213-8c4c-4', N'anhha423', N'Hà Tài Anh', N'anh@42390', N'ha.anh423@gmail.com', 2, N'0989956636', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c122c67f-eb1d-4', N'anthai458', N'Thái Bình An', N'an@45863', N'thai.an458@gmail.com', 2, N'0989196890', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c420c5b3-e022-4', N'phuongtran847', N'Trần Văn Phương', N'phuong@84721', N'tran.phuong847@gmail.com', 2, N'0988824325', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c5905842-416d-4', N'huychu531', N'Chu Văn Huy', N'huy@5317', N'chu.huy531@gmail.com', 2, N'0984307044', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c61faeac-0d8c-4', N'duongpham938', N'Phạm Việt Dương', N'duong@93838', N'pham.duong938@gmail.com', 2, N'0981857350', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c6ca1f60-ae6e-4', N'thinhdam641', N'Đàm Quang Thịnh', N'thinh@64198', N'dam.thinh641@gmail.com', 2, N'0986658151', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c762e68f-3bfc-4', N'khuongpham947', N'Phạm Văn Khương', N'khuong@94790', N'pham.khuong947@gmail.com', 2, N'0982375386', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-c7bfb0be-0ece-4', N'tuyetnguyen779', N'Nguyễn Thị Tuyết', N'tuyet@77928', N'nguyen.tuyet779@gmail.com', 2, N'0984839386', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cb334f23-a501-4', N'giangnguyen849', N'Nguyễn Hương Giang', N'giang@84939', N'nguyen.giang849@gmail.com', 2, N'0989182230', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cbbebfe7-6e27-4', N'anhnguyen261', N'Nguyễn Minh Anh', N'anh@26123', N'nguyen.anh261@gmail.com', 2, N'0982258492', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cbc93ed6-d84d-4', N'linhtruong442', N'Trương Khánh Linh', N'linh@44211', N'truong.linh442@gmail.com', 2, N'0985876899', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cbf45dea-97b8-4', N'hoangdao880', N'Đào Huy Hoàng', N'hoang@8800', N'dao.hoang880@gmail.com', 2, N'0984360453', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cda51010-c9cb-4', N'nampham498', N'Phạm Ngọc Nam', N'nam@49867', N'pham.nam498@gmail.com', 2, N'0989963800', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cdb93f74-0a16-4', N'tutran598', N'Trần Ngọc Tú', N'tu@59846', N'tran.tu598@gmail.com', 2, N'0983340889', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ce684ea6-7aa7-4', N'luongnguyen113', N'Nguyễn Thị Lương', N'luong@11357', N'nguyen.luong113@gmail.com', 2, N'0982452237', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cefe6952-60f6-4', N'hietmai401', N'Mai Văn Hiệt', N'hiet@40187', N'mai.hiet401@gmail.com', 2, N'0988199355', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cf081d01-45b1-4', N'minhle396', N'Lê Đình Minh', N'minh@39695', N'le.minh396@gmail.com', 2, N'0984047370', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-cfd6af4f-97d5-4', N'linhnguyen502', N'Nguyễn Thị Mỹ Linh', N'linh@50278', N'nguyen.linh502@gmail.com', 2, N'0984558172', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d067d57a-29d7-4', N'hoangvu237', N'Vũ Việt Hoàng', N'hoang@23728', N'vu.hoang237@gmail.com', 2, N'0986280265', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d1995d41-0e57-4', N'minhtran540', N'Trần Trọng Minh', N'minh@54047', N'tran.minh540@gmail.com', 2, N'0987691577', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d1e85f77-bb0b-4', N'thanhbui794', N'Bùi Văn Thành', N'thanh@79446', N'bui.thanh794@gmail.com', 2, N'0981581596', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d2e2c940-6ed5-4', N'ducnguyen681', N'Nguyễn Minh Đức', N'duc@68140', N'nguyen.duc681@gmail.com', 2, N'0987452239', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d417d499-2561-4', N'thunguyen142', N'Nguyễn Thị Thu', N'thu@14246', N'nguyen.thu142@gmail.com', 2, N'0983601920', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d75a7577-7b0b-4', N'maitruong446', N'Trương Thị Mai', N'mai@44673', N'truong.mai446@gmail.com', 2, N'0987329952', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d7950cbf-7d33-4', N'duyendo668', N'Đỗ Thị Duyên', N'duyen@66837', N'do.duyen668@gmail.com', 2, N'0986337314', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d8174e9f-e7ce-4', N'minhhoang114', N'Hoàng Văn Minh', N'minh@11480', N'hoang.minh114@gmail.com', 2, N'0981617468', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d90e2361-2600-4', N'tuannguyen351', N'Nguyễn Anh Tuấn', N'tuan@35188', N'nguyen.tuan351@gmail.com', 2, N'0986744389', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-d9201a3b-6e01-4', N'lannguyen892', N'Nguyễn Ngọc Lan', N'lan@89292', N'nguyen.lan892@gmail.com', 2, N'0986518081', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-da3f0724-4302-4', N'lydo433', N'Đỗ Thị Ly', N'ly@43388', N'do.ly433@gmail.com', 2, N'0985979655', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-daed1edf-8bef-4', N'trungdo774', N'Đỗ Thành Trung', N'trung@77451', N'do.trung774@gmail.com', 2, N'0985263503', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dafe3221-a0de-4', N'phuongdao176', N'Đào Thị Lan Phương', N'phuong@17642', N'dao.phuong176@gmail.com', 2, N'0988205539', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dbc7e612-2193-4', N'lele230', N'Lê Ngọc Lệ', N'le@23069', N'le.le230@gmail.com', 2, N'0982953078', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dc685c8d-b74d-4', N'ngocdao895', N'Đào Thị Ánh Ngọc', N'ngoc@89561', N'dao.ngoc895@gmail.com', 2, N'0987284237', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dc757647-08df-4', N'ducta734', N'Tạ Việt Đức', N'duc@73460', N'ta.duc734@gmail.com', 2, N'0988286842', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dca161fe-0ff2-4', N'thaole243', N'Lê Văn Thao', N'thao@24369', N'le.thao243@gmail.com', 2, N'0981319802', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dcb8a4ad-8ed6-4', N'vuluu623', N'Lưu Quang Vũ', N'vu@62318', N'luu.vu623@gmail.com', 2, N'0984826093', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dd31e526-f44e-4', N'duongngo651', N'Ngô Thị Dương', N'duong@65169', N'ngo.duong651@gmail.com', 2, N'0981804563', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-dd9977a6-9996-4', N'nganluong370', N'Lương Thị Ngân', N'ngan@37071', N'luong.ngan370@gmail.com', 2, N'0983826254', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ddb578b6-d574-4', N'vietduong817', N'Dương Vũ Hoàng Việt', N'viet@81771', N'duong.viet817@gmail.com', 2, N'0983149578', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ddce2079-d332-4', N'donguyen189', N'Nguyễn Huy Độ', N'do@18944', N'nguyen.do189@gmail.com', 2, N'0982104313', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-de3f2b99-9139-4', N'thangnguyen129', N'Nguyễn Trần Anh Thắng', N'thang@12914', N'nguyen.thang129@gmail.com', 2, N'0988569956', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-decea91e-2413-4', N'sonhoang187', N'Hoàng Thiên Sơn', N'son@18767', N'hoang.son187@gmail.com', 2, N'0982875803', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-df828638-fcd5-4', N'quynhdau195', N'Đậu Đinh Xuân Quỳnh', N'quynh@19573', N'dau.quynh195@gmail.com', 2, N'0981006734', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e02653c8-969a-4', N'nganguyen756', N'Nguyễn Thị Nga', N'nga@7567', N'nguyen.nga756@gmail.com', 2, N'0984339372', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e04a063d-585e-4', N'hoadao797', N'Đào Thu Hòa', N'hoa@79752', N'dao.hoa797@gmail.com', 2, N'0989498073', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e08be974-9a12-4', N'longbui205', N'Bùi Đình Long', N'long@20519', N'bui.long205@gmail.com', 2, N'0983064864', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e0c20570-0d79-4', N'toanly442', N'Lý Thanh Toản', N'toan@44227', N'ly.toan442@gmail.com', 2, N'0987313864', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e145651e-6791-4', N'hieungo212', N'Ngô Đình Hiếu', N'hieu@21281', N'ngo.hieu212@gmail.com', 2, N'0985198009', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e15b7957-ad0b-4', N'thanhtran344', N'Trần Thị Thanh', N'thanh@34491', N'tran.thanh344@gmail.com', 2, N'0987386447', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e17daa70-16b4-4', N'manhnguyen243', N'Nguyễn Chí Mạnh', N'manh@24328', N'nguyen.manh243@gmail.com', 2, N'0989134603', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e1dbc99e-4d81-4', N'hoado704', N'Đỗ Xuân Hòa', N'hoa@70465', N'do.hoa704@gmail.com', 2, N'0983137090', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e1ee8288-750a-4', N'locdo867', N'Đỗ Tiến Lộc', N'loc@86768', N'do.loc867@gmail.com', 2, N'0984125028', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e290e39d-7736-4', N'ngocnguyen150', N'Nguyễn Thị Ngọc', N'ngoc@15095', N'nguyen.ngoc150@gmail.com', 2, N'0983831952', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e39d231c-be22-4', N'khaichu819', N'Chu Đình Khải', N'khai@81958', N'chu.khai819@gmail.com', 2, N'0988468734', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e3a8d317-1331-4', N'thangnguyen303', N'Nguyễn Đức Thắng', N'thang@3030', N'nguyen.thang303@gmail.com', 2, N'0988721245', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e3edd4d4-940f-4', N'tiennguyen763', N'Nguyễn Văn Tiền', N'tien@7637', N'nguyen.tien763@gmail.com', 2, N'0988831168', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e439f88e-2e3e-4', N'huyly343', N'Lý Văn Huy', N'huy@34317', N'ly.huy343@gmail.com', 2, N'0984473242', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e4589ab9-7c49-4', N'anhdo898', N'Đỗ Tuấn Anh', N'anh@89879', N'do.anh898@gmail.com', 2, N'0987422522', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e75642c0-820e-4', N'luongdang784', N'Đặng Thị Hiền Lương', N'luong@78443', N'dang.luong784@gmail.com', 2, N'0988533541', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e8c8741a-a67e-4', N'hoangdo420', N'Đỗ Việt Hoàng', N'hoang@42086', N'do.hoang420@gmail.com', 2, N'0988496991', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-e9252a94-9d65-4', N'thangvu161', N'Vũ Đăng Thắng', N'thang@16132', N'vu.thang161@gmail.com', 2, N'0982793871', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-eaf65834-e158-4', N'hungdao649', N'Đào Việt Hưng', N'hung@64952', N'dao.hung649@gmail.com', 2, N'0985360436', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-eb468f7d-936b-4', N'thenguyen777', N'Nguyễn Văn Thể', N'the@77781', N'nguyen.the777@gmail.com', 2, N'0988115834', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ebb665ed-b8f4-4', N'lapdo583', N'Đỗ Xuân Lập', N'lap@58334', N'do.lap583@gmail.com', 2, N'0983698279', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ecdbd245-7fe5-4', N'leluong102', N'Lương Thị Nhật Lệ', N'le@10271', N'luong.le102@gmail.com', 2, N'0988774471', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ee21c95e-b14f-4', N'anhpham642', N'Phạm Thế Anh', N'anh@64274', N'pham.anh642@gmail.com', 2, N'0986733156', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ee5cc6ad-1357-4', N'tangdo188', N'Đỗ Văn Tăng', N'tang@18826', N'do.tang188@gmail.com', 2, N'0989426698', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-eef25645-9ca1-4', N'toanbui442', N'Bùi Thế Toàn', N'toan@44214', N'bui.toan442@gmail.com', 2, N'0989665749', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-ef35ab49-9782-4', N'huongnguyen673', N'Nguyễn Thị Thu Hưởng', N'huong@67327', N'nguyen.huong673@gmail.com', 2, N'0986769205', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f007ed54-aa2e-4', N'tannguyen881', N'Nguyễn Đức Tân', N'tan@88199', N'nguyen.tan881@gmail.com', 2, N'0981327953', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f0209212-7b69-4', N'thanhnguyen386', N'Nguyễn Đình Thành', N'thanh@38682', N'nguyen.thanh386@gmail.com', 2, N'0985364389', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f0353506-b88c-4', N'longdang377', N'Đặng Hoàng Long', N'long@37780', N'dang.long377@gmail.com', 2, N'0988154032', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f0549f4f-297f-4', N'viethoang985', N'Hoàng Việt', N'viet@98555', N'hoang.viet985@gmail.com', 2, N'0983191956', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f062fedc-c3ff-4', N'anhnguyen312', N'Nguyễn Tuấn Anh', N'anh@3123', N'nguyen.anh312@gmail.com', 2, N'0985822713', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f07f4d5d-2587-4', N'lydoan839', N'Đoàn Hương Ly', N'ly@83968', N'doan.ly839@gmail.com', 2, N'0989565263', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f357c01c-52ab-4', N'tienbui555', N'Bùi Văn Tiến', N'tien@55541', N'bui.tien555@gmail.com', 2, N'0982388951', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f35cdbd6-7984-4', N'quangdo101', N'Đỗ Đình Quang', N'quang@10151', N'do.quang101@gmail.com', 2, N'0986261349', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f3ac651f-76d5-4', N'khiemnguyen975', N'Nguyễn Văn Khiêm', N'khiem@97513', N'nguyen.khiem975@gmail.com', 2, N'0982643223', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f410452c-71ec-4', N'thaodo497', N'Đỗ Phương Thảo', N'thao@49730', N'do.thao497@gmail.com', 2, N'0981983602', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f58c451f-a172-4', N'thangnguyen861', N'Nguyễn Việt Thắng', N'thang@8618', N'nguyen.thang861@gmail.com', 2, N'0987393937', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f84d525b-4d8a-4', N'huynhdo430', N'Đỗ Văn Huynh', N'huynh@43096', N'do.huynh430@gmail.com', 2, N'0987396938', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f85cce92-4b02-4', N'thuyha531', N'Hà Đăng Thủy', N'thuy@53172', N'ha.thuy531@gmail.com', 2, N'0989092837', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f89d6c4a-5159-4', N'anhpham602', N'Phạm Duy Anh', N'anh@60298', N'pham.anh602@gmail.com', 2, N'0983111436', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-f8f006b9-e3a4-4', N'longle724', N'Lê Thành Long', N'long@72428', N'le.long724@gmail.com', 2, N'0985075901', N'https://imgur.com/yWLxOxv.png')
--INSERT [dbo].[tbl_user] ([id], [username], [name], [pw], [email], [role_id], [p_number], [img]) VALUES (N'u-fd573c15-c437-4', N'lamnguyen869', N'Nguyễn Sơn Lâm', N'lam@86958', N'nguyen.lam869@gmail.com', 2, N'0987444324', N'https://imgur.com/yWLxOxv.png')
--GO


