public with sharing class ChartControllerPDP {
    public static Integer year {
        get {
            if (year == null) year = 2022;
            return year;
        }
        set;
    }

    public List<ChartData> getChartData() {
        return ChartControllerPDP.getChartDataByYear();
    }

    public static List<SelectOption> getChartYearOptions() {
        List<SelectOption> years = new List<SelectOption>();
        years.add(new SelectOption('2022','2022'));
        years.add(new SelectOption('2021','2021'));
        years.add(new SelectOption('2020','2020'));
        return years;
    }

    public static List<ChartData> getChartDataByYear() {
        if (year == null) return new List<ChartData>();

        List<ChartData> data = new List<ChartData>();
        Date ControlStartDate = Date.newInstance(year, 1, 1);
        Date ControlEndDate = Date.newInstance(year, 12, 31);


        List<Contract> foundContract = [
                SELECT Price__c,
                        Status,
                        StartDate
                FROM Contract
                WHERE StartDate >= :ControlStartDate AND StartDate <= :ControlEndDate AND Price__c != NULL
        ];
        System.debug(foundContract);

        Map<Integer, List<Contract>> contractByStartMonth = new Map<Integer, List<Contract>>();

        for (Contract contract : foundContract) {
            Integer month = contract.StartDate.month();

            if (contractByStartMonth.containsKey(month)) {
                contractByStartMonth.get(month).add(contract);
            } else {
                contractByStartMonth.put(month, new List<Contract>{contract});
            }
        }

        for (Integer i = 1; i <= 12; i++) {
            if (contractByStartMonth.containsKey(i)) {
                Decimal finishedAmount = 0;
                Decimal otherAmount = 0;

                for (Contract contract : contractByStartMonth.get(i)) {
                    if (contract.Status == 'Finished') {
                        finishedAmount = finishedAmount + contract.Price__c;
                    } else {
                        otherAmount = otherAmount + contract.Price__c;
                    }
                }
                data.add(new ChartData (i, finishedAmount, otherAmount));
            } else {
                data.add(new ChartData (i, 0, 0));
            }
        }

        return data;
    }

    public class ChartData {
        public Integer month { get; set; }
        public Decimal contractAmountFinished { get; set; }
        public Decimal contractAmountOtherStatus { get; set; }
        public ChartData(Integer month, Decimal contractAmountFinished, Decimal contractAmountOtherStatus) {
            this.month = month;
            this.contractAmountFinished = contractAmountFinished;
            this.contractAmountOtherStatus = contractAmountOtherStatus;
        }
    }
}