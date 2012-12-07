#import <UIKit/UIKit.h>
#import <EKKeyboardAvoidingScrollView/CGRectTransform.h>

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CGRectTransforming)

describe(@"CGRect transformation:", ^{
    context(@"CGRectTransformLeft",^{
        it(@"Rectangle {{10,15},{50,100}} in view with size {320,480} should be transformed to {{15,260},{100,50}}", ^{
            CGRect baseRect = CGRectMake(10, 15, 50, 100);
            CGRect transformedRect = CGRectTransformed(baseRect, {320,480}, CGRectTransformRotateLeft);
            expect(transformedRect.origin.x).to(equal(15));
            expect(transformedRect.origin.y).to(equal(260));
            expect(transformedRect.size.width).to(equal(100));
            expect(transformedRect.size.height).to(equal(50));
        });
    });
    
    context(@"CGRectTransformRight",^{
        it(@"Rectangle {{10,15},{50,100}} in view with size {320,480} should be transformed to {{365,10},{100,50}}", ^{
            CGRect baseRect = CGRectMake(10, 15, 50, 100);
            CGRect transformedRect = CGRectTransformed(baseRect, {320,480}, CGRectTransformRotateRight);
            expect(transformedRect.origin.x).to(equal(365));
            expect(transformedRect.origin.y).to(equal(10));
            expect(transformedRect.size.width).to(equal(100));
            expect(transformedRect.size.height).to(equal(50));
        });
    });
    
    context(@"CGRectTransformExpand",^{
        it(@"Rectangle {{10,15},{50,100}} in view with size {320,480} should be transformed to {{260,365},{50,100}}", ^{
            CGRect baseRect = CGRectMake(10, 15, 50, 100);
            CGRect transformedRect = CGRectTransformed(baseRect, {320,480}, CGRectTransformExpand);
            expect(transformedRect.origin.x).to(equal(260));
            expect(transformedRect.origin.y).to(equal(365));
            expect(transformedRect.size.width).to(equal(50));
            expect(transformedRect.size.height).to(equal(100));
        });
    });
});

SPEC_END

