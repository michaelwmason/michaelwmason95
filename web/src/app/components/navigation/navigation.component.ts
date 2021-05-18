import { Component, OnInit } from '@angular/core'
import { Observable } from 'rxjs'
import { map } from 'rxjs/operators'
import { Location } from 'src/app/models/location'
import { NavigationService } from 'src/app/services/navigation/navigation.service'

@Component({
    templateUrl: './navigation.component.html',
    styleUrls: ['./navigation.component.scss'],
    selector: 'app-navigation-component',
})
export class NavigationComponent implements OnInit {
    constructor(private navigationService: NavigationService) {}

    ngOnInit(): void {}

    isSelected(location: string): Observable<boolean> {
        return this.navigationService.currentLocation$.pipe(
            map((l) => l === location)
        )
    }
}
