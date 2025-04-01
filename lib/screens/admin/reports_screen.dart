import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:hatan/bloc/chart_cubit.dart';
import 'package:hatan/models/section.dart';


class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:  const Color(0xFFA0dbf1),
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left , color: Colors.black,),),
          title:  const Text('التقارير' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

        ),
        backgroundColor:  const Color(0xFFA0dbf1),
        body: BlocProvider(
          create: (context) => ChartCubit()..getEventsChart(),
          child: BlocConsumer<ChartCubit, ChartState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              String reportOf = ChartCubit.get(context).reportOf;
              int year = ChartCubit.get(context).year;
              int? selectedSectionId = ChartCubit.get(context).selectedSectionId;
              int? selectedTeamId = ChartCubit.get(context).selectedTeamId;


              if(state is ChartError) {
                return Center(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'عذراً حدث خطأ ما',
                          style: TextStyle(
                              color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            ChartCubit.get(context).getEventsChart();
                          },
                          child: const Text(
                            'إعادة محاولة',
                            style: TextStyle(
                                color:  Colors.indigo,fontSize: 18, fontFamily: 'Tajawal', fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                      ],
                    )
                );
              }




              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'تقارير:' ,labelStyle: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        value:reportOf,
                        items: ['الفعاليات','الأقسام','الفرق'].map((index) {
                          return DropdownMenuItem<String>(
                            value: index,
                            alignment: Alignment.centerRight,
                            child: Text(index.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value == null){
                            return;
                          }

                          ChartCubit.get(context).reportOf = value;
                          if(value == 'الفعاليات'){
                            ChartCubit.get(context).getEventsChart();
                          }else{
                            ChartCubit.get(context).update();
                          }
                        },
                      ),
                    ),

                    if(reportOf == 'الأقسام')
                      Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'القسم:' ,labelStyle: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        value:selectedSectionId,
                        items: ChartCubit.get(context).sections.map((section) {
                          return DropdownMenuItem<int>(
                            value: section.id,
                            alignment: Alignment.centerRight,
                            child: Text(section.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value == null){
                            return;
                          }
                          ChartCubit.get(context).selectedSectionId = value;
                          ChartCubit.get(context).getSectionChart();
                        },
                      ),
                    ),
                    if(reportOf == 'الفرق')
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonFormField<int>(
                          decoration: const InputDecoration(labelText: 'الفريق:' ,labelStyle: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                          value:selectedTeamId,
                          items: ChartCubit.get(context).teams.map((team) {
                            return DropdownMenuItem<int>(
                              value: team.id,
                              alignment: Alignment.centerRight,
                              child: Text(team.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if(value == null){
                              return;
                            }
                            ChartCubit.get(context).selectedTeamId = value;
                            ChartCubit.get(context).getTeamChart();
                          },
                        ),
                      ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'السنة:' ,labelStyle: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        value:year,
                        items: List.generate(100, (index) => index+1430).map((index) {
                          return DropdownMenuItem<int>(
                            value: index,
                            alignment: Alignment.centerRight,
                            child: Text(index.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value == null){
                            return;
                          }

                          ChartCubit.get(context).year = value;
                          if(reportOf == 'الفعاليات'){
                            ChartCubit.get(context).getEventsChart();
                          }else if(reportOf == 'الأقسام'){
                            ChartCubit.get(context).getSectionChart();
                          }else{
                            ChartCubit.get(context).getTeamChart();
                          }
                        },
                      ),
                    ),
                    if(state is ChartLoading)
                      Container(
                        height: 300,width: width,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                    if(state is ChartDown)
                      SizedBox( height: 300,width: width, child: chartToRun(ChartCubit.get(context).data , reportOf)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget chartToRun(List<double> data , String reportOf) {
  if(reportOf != 'الفعاليات'){
    reportOf = 'المتطوعين';
  }

  LabelLayoutStrategy? xContainerLabelLayoutStrategy;
  ChartData chartData;
  ChartOptions chartOptions = const ChartOptions(
    dataContainerOptions: DataContainerOptions(gridLinesColor: Colors.blue),
    labelCommonOptions: LabelCommonOptions(labelTextScaleFactor: .8,labelTextAlign: TextAlign.center),
      xContainerOptions: XContainerOptions(xBottomMinTicksHeight: 20,),
      iterativeLayoutOptions: IterativeLayoutOptions(labelTiltRadians: -1.5)
  );
  
  chartData = ChartData(
    dataRows: [
      data,
    ],
    xUserLabels: const ["محرم", "صفر", "ربيع الاول", "ربيع الثاني", "جمادى الاول", "جمادى الثاني", "رجب", "شعبان", "رمضان", "شوال", "ذو القعدة", "ذو الحجة",],
    dataRowsLegends: [
      'عدد $reportOf',
    ],
    chartOptions: chartOptions,
  );
  var verticalBarChartContainer = VerticalBarChartTopContainer(
    chartData: chartData,
    xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
  );

  var verticalBarChart = VerticalBarChart(
    painter: VerticalBarChartPainter(
      verticalBarChartContainer: verticalBarChartContainer,
    ),
  );
  return verticalBarChart;
}