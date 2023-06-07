import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:yoga_student_app/lang/message.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nContent.privacy),
      ),
      body: ListView(
        children: [
//           Container(
//             padding: EdgeInsets.all(15),
//             child: Text('''
//
// 透過使用MeMoYoga網站，你同意我們的私隱政策。
//
// 1. 個人資料
// 除非網站訪客自願將其個人資料輸入我們的用戶登記冊內，本網站並不記錄或儲存網站訪客的個人資料，但登錄你的網際網路通訊協定地址及期間資料(例如到訪本網站的期間及所使用的網頁瀏覽器的類別)除外。為免生疑問，你可自願向我們提供個人資料，作訂購通訊及任何其他由MeMoYoga發布的有關材料的用途。
//
// 我們可使用任何由你自願輸入的資料，以通知你我們認為你有興趣的有關任何由MeMoYago提供的的資料變更及/或新的資訊(例如特別優惠、售後服務、統計、研究、直接銷售、直接促銷及推廣)。為了該等用途的目的，我們將會在香港地區以內或以外搜集、使用、儲存、處理及傳送你的個人資料(包括但不限於你的姓名、電郵地址及專業職稱)，我們亦可向協助我們處理資料的服務提供者、推廣活動合作伙伴及研究機構發出此等資料。
//
// 但是，除非我們已按情況而取得你明示的同意，使用你的個人資料作我們進行的直接促銷活動及/或為了其他第三者進行的直接促銷活動提供你的個人資料，否則我們不得使用你的個人資料作上述用途。
//
// 你有權在任何時間要求我們停止使用你的個人資料。如你在同意我們使用你的個人資料作上述用途後意欲撤回該同意，請電郵至memoyogahk@gmail.com 以聯絡我們。
//
// 2. 資料登記冊的位置
// MeMoYoga 可傳送你的個人資料至位於香港以外地方的資料登記冊伺服器。透過通過本網址傳送任何個人資料至MeMoYoga，你已同意MeMoYoga以上述形式傳送你的個人資料。
//
// 3. 查閱及更正資料的權利
// 你有權查閱我們所持有你的個人資料，及要求更正資料任何該等個人資料。
//
// 如欲要求查閱或更正資料，請電郵至memoyogahk@gmail.com 以聯絡我們。
//
// 4. 第三者連結
// 此私隱政策並不涵蓋本網站連結的其他網站。
//
// 5. 一般條款
// 如此私隱政策的此英文及中文版本有任何意義差歧或抵觸，以中文版本為準
//
//         '''),
//           ),
          Container(
            padding: EdgeInsets.all(15),
            child: HtmlWidget('''
            <h1>Privacy Policy</h1>
<p>Last updated: June 02, 2023</p >
<p>This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.</p >
<p>We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the <a href=" " target="_blank">TermsFeed Privacy Policy Generator</a >.</p >
<h1>Interpretation and Definitions</h1>
<h2>Interpretation</h2>
<p>The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.</p >
<h2>Definitions</h2>
<p>For the purposes of this Privacy Policy:</p >
<ul>
<li>
<p><strong>Account</strong> means a unique account created for You to access our Service or parts of our Service.</p >
</li>
<li>
<p><strong>Affiliate</strong> means an entity that controls, is controlled by or is under common control with a party, where &quot;control&quot; means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.</p >
</li>
<li>
<p><strong>Application</strong> refers to MeMoYoga, the software program provided by the Company.</p >
</li>
<li>
<p><strong>Company</strong> (referred to as either &quot;the Company&quot;, &quot;We&quot;, &quot;Us&quot; or &quot;Our&quot; in this Agreement) refers to MeMoYoga HK Co., Ltd., Room B, HAVEN COMMERCIAL BUILDING, 4/F Tsing Fung St, Causeway Bay.</p >
</li>
<li>
<p><strong>Country</strong> refers to:  Hong Kong SAR China</p >
</li>
<li>
<p><strong>Device</strong> means any device that can access the Service such as a computer, a cellphone or a digital tablet.
            '''
            ),
          ),
        ],
      ),
    );
  }
}
