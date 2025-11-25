import 'package:flutter/material.dart';


class DaftarAntrian extends StatefulWidget {
  DaftarAntrian({super.key});

  @override
  State<StatefulWidget> createState() => _DaftarAntrian();
}

class _DaftarAntrian extends State<DaftarAntrian> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: 390,
        height: 844,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          border: Border.all(color: const Color(0xff000000), width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              width: 390,
              top: 0,
              height: 44,
              child: Container(
                width: 390,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 308.667,
                      width: 66.661,
                      top: 17.331,
                      height: 11.336,
                      child: Image.asset('images/image_I7693612047843.png', width: 66.661, height: 11.336,),
                    ),
                    Positioned(
                      left: 24,
                      width: 54,
                      top: 12,
                      height: 21,
                      child: Container(
                        width: 54,
                        height: 21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              width: 54,
                              top: 0,
                              height: 21,
                              child: Container(
                                width: 54,
                                height: 21,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      width: 54,
                                      top: 1,
                                      height: 20,
                                      child: Text(
                                        '9:41',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(decoration: TextDecoration.none, fontSize: 15, color: const Color(0xff000000), fontFamily: 'Inter-Medium', fontWeight: FontWeight.normal),
                                        maxLines: 9999,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: -1,
              width: 390,
              top: 116,
              height: 146,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          'Pilih Poli',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: const Color(0xff18181b), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                          maxLines: 9999,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          'Buat antrian poli baru',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: const Color(0xff3f3f46), fontFamily: 'Manrope-Medium', fontWeight: FontWeight.normal),
                                          maxLines: 9999,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(0xffcdd1f5),
                                                  border: Border.all(color: const Color(0xffffffff), width: 1),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Image.asset('images/image_I8037812047215.png', width: 24, height: 24,),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child: Container(
                                                          width: double.infinity,
                                                          child: Text(
                                                            'Poli mata....',
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14, color: const Color(0xff71717a), fontFamily: 'Manrope-Medium', fontWeight: FontWeight.normal),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset('images/image_80379.png',),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              width: 390,
              top: 823,
              height: 21,
              child: Image.asset('images/image_80491.png', width: 390, height: 21,),
            ),
            Positioned(
              left: 0,
              width: 390,
              top: 44,
              height: 59,
              child: Container(
                width: 390,
                height: 59,
                decoration: BoxDecoration(
                  color: const Color(0xff3d4eb0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/image_85879.png', width: 24, height: 24,),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'Daftar Antrian Baru',
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: const Color(0xffffffff), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                            maxLines: 9999,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              width: 390,
              top: 276,
              height: 418,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 375,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xfff9f5ff),
                                border: Border.all(color: const Color(0xffc6d4f1), width: 1),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 6, right: 12, bottom: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '🏻',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(decoration: TextDecoration.none, fontSize: 28, color: const Color(0xff000000), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                      maxLines: 9999,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Poli THT',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: const Color(0xff18181b), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Layanan spesialis telinga, hidung, dan tenggorokan',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: const Color(0xff71717a), fontFamily: 'Manrope-Medium', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Image.asset('images/image_80435.png', width: 24, height: 24,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 375,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xfff9f5ff),
                                border: Border.all(color: const Color(0xffc6d4f1), width: 1),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 6, right: 12, bottom: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '🧠',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(decoration: TextDecoration.none, fontSize: 28, color: const Color(0xff000000), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                      maxLines: 9999,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Poli Jiwa',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: const Color(0xff18181b), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Layanan kesehatan mental dan konsultasi psikologis',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: const Color(0xff71717a), fontFamily: 'Manrope-Medium', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Image.asset('images/image_80442.png', width: 24, height: 24,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 375,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xfff9f5ff),
                                border: Border.all(color: const Color(0xffc6d4f1), width: 1),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 6, right: 12, bottom: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '🦷',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(decoration: TextDecoration.none, fontSize: 28, color: const Color(0xff000000), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                      maxLines: 9999,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Poli Gigi',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: const Color(0xff18181b), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Layanan gigi dan mulut',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: const Color(0xff71717a), fontFamily: 'Manrope-Medium', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Image.asset('images/image_80449.png', width: 24, height: 24,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 375,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xfff9f5ff),
                                border: Border.all(color: const Color(0xffc6d4f1), width: 1),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 6, right: 12, bottom: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '🤌',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(decoration: TextDecoration.none, fontSize: 28, color: const Color(0xff000000), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                      maxLines: 9999,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Poli Kulit',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: const Color(0xff18181b), fontFamily: 'Manrope-Bold', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Layanan pemeriksaan dan perawatan masalah kulit',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: const Color(0xff71717a), fontFamily: 'Manrope-Medium', fontWeight: FontWeight.normal),
                                              maxLines: 9999,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Image.asset('images/image_80456.png', width: 24, height: 24,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
