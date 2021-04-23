import "package:flutter/material.dart";

class PriceRateItem extends StatelessWidget {
  final String day;
  final String startingHour;
  final String endingHour;
  final int priceRate;

  const PriceRateItem({
    this.day,
    this.startingHour,
    this.endingHour,
    this.priceRate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(
            day,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
              height: 300,
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            "\$$priceRate",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      title: Text(
                        "$startingHour - $endingHour",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  );
                },
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
