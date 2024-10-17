import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'currency',
  standalone: true
})
export class CurrencyPipe implements PipeTransform {

  transform(value: string | number): string {
    value = Number(value);
    if(value % 2 === 0){
      return `CHF ${value}.-`
    } else {
      return `CHF ${value}`
    }
  }

}
