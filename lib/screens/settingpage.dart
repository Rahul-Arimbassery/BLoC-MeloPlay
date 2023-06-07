import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: const Color.fromARGB(255, 27, 164, 179),
        elevation: 10,
        backgroundColor: Colors.black,
        title: Text(
          'Settings',
          style: GoogleFonts.acme(
            textStyle: const TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 254, 254, 253),
              Color.fromARGB(255, 61, 61, 58),
            ],
            center: Alignment.topLeft,
            radius: 2,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('About us'),
                          content: const SingleChildScrollView(
                              child: Text(
                            'Welcome to MeloPlay, your ultimate offline music companion! At MeloPlay, we believe that music has the power to uplift, inspire, and connect people from all walks of life. Our mission is to provide a seamless and immersive music experience that lets you enjoy your favorite tunes anytime, anywhere, without the need for an internet connection.\n \nApp Developed by - Rahul R\n \n📜 Queries - rahulr441989@gmail.com',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          )),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_3,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'About us',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(fontSize:18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Share'),
                          content: const Text('Share'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Share',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Privacy'),
                          content: const SingleChildScrollView(
                            child: Text(
                                '''Rahul R built the "MeloPlay" app as a Free app. This Service is provided by Rahul R at no cost and is intended for use as is.
      
This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.
      
If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.
      
The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at MeloPlay unless otherwise defined in this Privacy Policy.
      
      ✔️ Information Collection and Use
      
For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.
      
The app does use third-party services that may collect information used to identify you.
      
Link to the privacy policy of third-party service providers used by the app
      
Google Play Services
Google Analytics for Firebase
      
      ✔️ Log Data
      
I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.
      
      ✔️ Cookies
      
Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.
      
This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.
      
      ✔️ Service Providers
      
I may employ third-party companies and individuals due to the following reasons:
      
- To facilitate our Service;
- To provide the Service on our behalf;
- To perform Service-related services; or
- To assist us in analyzing how our Service is used.
      
I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.
      
      ✔️ Security
      
I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.
      
      ✔️ Links to Other Sites
      
This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.
      
      ✔️ Children’s Privacy
      
These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.
      
      ✔️ Changes to This Privacy Policy
      
I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.
      
This policy is effective as of 2023-06-07
      
      ✔️ Contact Us
      
If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at connect rahulr441989@gmail.com.'''),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.privacy_tip,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Privacy',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Terms and conditions'),
                          content: const SingleChildScrollView(
                            child: Text(
                                '''Welcome to MeloPlay! These Terms and Conditions ("Terms") govern your use of the MeloPlay offline music app ("the App") and its associated services. By using the App, you agree to abide by these Terms. If you do not agree to these Terms, please refrain from using the App.
                          
      ✔️ App Usage
      
1.1 You must be at least 13 years old to use the App. If you are under the age of 13, you may only use the App under the supervision of a parent or legal guardian.

1.2 The App is for personal, non-commercial use only. You may not use the App for any commercial purpose without obtaining prior written permission from the App's owners.

1.3 You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account or any other breach of security.
                          
      ✔️ Intellectual Property Rights
      
2.1 The App and all its content, including but not limited to text, graphics, logos, images, and software, are the intellectual property of MeloPlay or its licensors. These materials are protected by copyright, trademark, and other intellectual property laws.

2.2 You may not modify, reproduce, distribute, create derivative works, publicly display or perform, or in any way exploit any of the content available on the App, except as expressly permitted by these Terms or with prior written consent from MeloPlay.
                          
      ✔️ Offline Music Downloads
      
3.1 The App allows you to download and listen to music offline for personal use. You may not share, distribute, or transfer the downloaded music files to any other person or device.

3.2 The availability of offline music is subject to the licensing agreements between MeloPlay and the respective music providers. MeloPlay does not guarantee the availability of specific songs or albums for offline downloading.
                          
      ✔️ User Content
      
4.1 You may have the option to upload, submit, or otherwise make available user-generated content through the App. By doing so, you grant MeloPlay a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, adapt, publish, translate, distribute, and display your user-generated content for the purposes of operating and improving the App.

4.2 You are solely responsible for the user-generated content you provide and must ensure that it does not violate any third-party rights or applicable laws. MeloPlay reserves the right to remove any user-generated content that is deemed inappropriate or violates these Terms.
                          
      ✔️ Privacy
      
5.1 Your privacy is important to us. Please refer to our Privacy Policy for information on how we collect, use, and protect your personal data.
                          
      ✔️ Termination
      
6.1 MeloPlay may suspend or terminate your access to the App at any time, without prior notice, for any reason or no reason, including if you violate these Terms.

6.2 You may stop using the App at any time and request the deletion of your account and associated data by contacting MeloPlay's support.
                          
      ✔️ Disclaimer of Warranties and Liability
      
7.1 The App is provided on an "as is" and "as available" basis. MeloPlay makes no warranties, express or implied, regarding the App's reliability, accuracy, availability, or suitability for any purpose. You use the App at your own risk.

7.2 MeloPlay shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of or in connection with your use of the App, including but not limited to any errors or omissions in the content, loss of data, or interruption of service.
                          
      ✔️ Changes to the Terms
      
8.1 MeloPlay reserves the right to modify or update these Terms at any time without prior notice. It is your responsibility to review the Terms periodically for any changes.
                          
      ✔️ Governing Law and Jurisdiction
      
9.1 These Terms shall be governed by and construed in accordance with the laws.. Any dispute arising out of or in connection with these Terms shall be submitted to the exclusive jurisdiction of the courts.
                          
      By using the MeloPlay offline music app, you acknowledge that you have read, understood, and agree to abide by these Terms and Conditions. '''),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.policy,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Terms and Conditions',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(fontSize: 18), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
